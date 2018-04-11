class TripRepository < Hanami::Repository
  associations do
    has_many :housings
    has_many :trip_organizers
  end

  def all_for_organizer_by_status(organizer_id, status)
    # No ROM here, we have to use a specific left join
    all_trips = trips_with_stats.
      join_table(:inner, :trip_organizers, trip_id: Sequel.qualify(:trips, :id)).
      where(organizer_id: organizer_id)

    case status
    when :future
      all_trips = all_trips.
        where { starting_on > Date.today }.
        order(:starting_on)
    when :ongoing
      all_trips = all_trips.
        where { starting_on <= Date.today }.
        where { ending_on >= Date.today }.
        order(:starting_on)
    when :completed
      all_trips = all_trips.
        where { ending_on < Date.today }.
        order { ending_on.desc }
    end

    return all_trips.to_a.map { |attributes| TripWithStats.new(attributes) }
  end

  def create_with_organizer(data)
    assoc(:trip_organizers).create(data)
  end

  def find_with_stats(id)
    # No ROM here, we have to use a specific left join
    attributes = trips_with_stats.
      where(Sequel.qualify(:trips, :id) =>  id).
      first

    return unless attributes
    TripWithStats.new(attributes)
  end

  def count
    trips.count
  end

  private

  def trips_with_stats
    # No ROM here, we have to implement a specific left join
    housing_stats = relations[:housings].select {
        [
          :trip_id,
          int::count(Sequel.qualify(:housings, :id)).as(:housings_count),
          int::avg(:total_price).as(:total_price_avg),
          int::min(:total_price).as(:total_price_min),
          int::max(:total_price).as(:total_price_max)
        ]
      }.
      where(dismissed: false).
      group(:trip_id).
      order(:trip_id)

    relations[:trips].
      dataset.
      select_all(:trips).
      select_append(:housings_count, :total_price_avg, :total_price_min, :total_price_max).
      join_table(:left, housing_stats.dataset, trip_id: :id).
      order(:id)
  end
end

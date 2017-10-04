class TripRepository < Hanami::Repository
  associations do
    has_many :housings
    has_many :trip_organizers
  end

  def all_for_organizer_by_status(organizer_id, status)
    all_trips = trips_with_stats.
      join(:trip_organizers).
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

    return all_trips.as(TripWithStats).to_a
  end

  def create_with_organizer(data)
    assoc(:trip_organizers).create(data)
  end

  def find_with_housings(id)
    aggregate(:housings).where(id: id).as(Trip).one
  end

  def find_with_organizers(id)
    aggregate(:trip_organizers).where(id: id).as(Trip).one
  end

  def find_with_stats(id)
    trips_with_stats.
      where(Sequel.qualify(:trips, :id) =>  id).
      as(TripWithStats).
      one
  end

  def count
    trips.count
  end

  private

  def trips_with_stats
    relations[:trips].
      left_join(relations[:housings]). # auto qualifies the columns
      select_append {
        [
          int::count('housings.id').as(:housings_count),
          int::avg(:total_price).as(:total_price_avg),
          int::min(:total_price).as(:total_price_min),
          int::max(:total_price).as(:total_price_max)
        ]
      }.
      group(:id)
  end
end

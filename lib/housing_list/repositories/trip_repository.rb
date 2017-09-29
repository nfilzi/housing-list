class TripRepository < Hanami::Repository
  associations do
    has_many :housings
    has_many :trip_organizers
  end

  def all_for_organizer_by_status(organizer_id, status)
    all_trips = relations[:trips].
      join(:trip_organizers).
      left_join(:housings).
      select_append {
        [
          int::count(Sequel.qualify('housings', 'id')).as(:housings_count),
          int::avg(Sequel.qualify('housings', 'total_price')).as(:total_price_avg)
        ]
      }.
      where(organizer_id: organizer_id).
      group(:id)

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
        order(Sequel.desc(:ending_on))
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

  def stats_for_trip(trip_id)
    stats = relations[:housings].select {
        [
          :trip_id,
          int::count(id).as(:housings_count),
          int::avg(total_price).as(:total_price_avg),
          int::min(total_price).as(:total_price_min),
          int::max(total_price).as(:total_price_max)
        ]
      }.
      where(trip_id: trip_id).
      group(:trip_id).
      order(:trip_id). # provided by Hanami/ROM by default :/
      as(TripHousingStats).
      one

    stats || TripHousingStats.new(trip_id: trip_id)
  end

  def count
    trips.count
  end
end

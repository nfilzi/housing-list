class TripRepository < Hanami::Repository
  associations do
    has_many :housings
    has_many :trip_organizers
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

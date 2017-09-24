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

  def count
    trips.count
  end
end

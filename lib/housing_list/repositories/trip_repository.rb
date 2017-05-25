class TripRepository < Hanami::Repository
  associations do
    has_many :housings
    has_many :trip_organizers
  end

  def find_with_housings(id)
    aggregate(:housings).where(id: id).as(Trip).one
  end
end

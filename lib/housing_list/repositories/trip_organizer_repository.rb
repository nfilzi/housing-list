class TripOrganizerRepository < Hanami::Repository
  def organizes_trip?(id, trip_id)
    trip_organizers.where(organizer_id: id, trip_id: trip_id).exist?
  end
end

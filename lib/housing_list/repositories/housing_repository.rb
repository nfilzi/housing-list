class HousingRepository < Hanami::Repository
  associations do
    belongs_to :trip
    belongs_to :user
  end

  def find_for_trip(id, trip_id)
    housings.where(trip_id: trip_id, id: id).one
  end

  def find_with_user(id)
    wrap_user.by_pk(id).as(Housing).one
  end

  def active_for_trip_sorted_by_most_recent(trip_id)
    for_trip_sorted_by_most_recent(trip_id).where(dismissed: false).as(Housing).to_a
  end

  def dismissed_for_trip_sorted_by_most_recent(trip_id)
    for_trip_sorted_by_most_recent(trip_id).where(dismissed: true).as(Housing).to_a
  end

  private

  def for_trip_sorted_by_most_recent(trip_id)
    wrap_user.where(trip_id: trip_id).order { created_at.desc }
  end

  def wrap_user
    relations[:housings].wrap(:user)
  end
end

class HousingRepository < Hanami::Repository
  associations do
    belongs_to :trip
    belongs_to :user
  end

  def find_with_user(id)
    wrap_user.by_pk(id).as(Housing).one
  end

  def for_trip_sorted_by_most_recent(trip_id)
    wrap_user.where(trip_id: trip_id).order { created_at.desc }.as(Housing).to_a
  end

  private

  def wrap_user
    relations[:housings].wrap(:user)
  end
end

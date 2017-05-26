class HousingRepository < Hanami::Repository
  associations do
    belongs_to :trip
    belongs_to :user
  end

  def all_by_trip_with_user(trip_id)
    wrap_user.where(trip_id: trip_id).as(Housing).to_a
  end

  def find_with_user(id)
    wrap_user.by_pk(id).as(Housing).one
  end

  private

  def wrap_user
    relations[:housings].wrap(:user)
  end
end

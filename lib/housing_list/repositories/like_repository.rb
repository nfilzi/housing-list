class LikeRepository < Hanami::Repository
  associations do
    belongs_to :housing
    belongs_to :user
  end

  def find_for_user_and_housing(user_id, housing_id)
    likes.where(user_id: user_id, housing_id: housing_id).one
  end
end

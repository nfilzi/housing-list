require 'hanami/interactor'

module Likes
  class Create
    include Hanami::Interactor

    private
    attr_reader :user, :housing

    public
    def initialize(user, housing)
      @user     = user
      @housing  = housing
    end

    def call
      LikeRepository.new.create(like_params)
    end

    private

    def like_params
      {
        user_id:    user.id,
        housing_id: housing.id
      }
    end
  end
end

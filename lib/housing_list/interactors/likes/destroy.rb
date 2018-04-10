require 'hanami/interactor'

module Likes
  class Destroy
    include Hanami::Interactor

    private
    attr_reader :user, :housing

    public
    def initialize(user, housing)
      @user    = user
      @housing = housing
    end

    def call
      like = LikeRepository.new.find_for_user_and_housing(user.id, housing.id)
      LikeRepository.new.delete(like.id)
    end
  end
end

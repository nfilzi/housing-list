require 'hanami/interactor'

module Likes
  class Destroy
    include Hanami::Interactor

    private
    attr_reader :like

    public
    def initialize(user, housing)
      @like = LikeRepository.new.find_for_user_and_housing(user.id, housing.id)
    end

    def call
      LikeRepository.new.delete(like.id)
    end
  end
end

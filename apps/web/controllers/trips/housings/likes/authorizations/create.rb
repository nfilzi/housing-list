module Web::Trips::Housings::Likes::Authorizations
  class Create
    include ::Web::Trips::Authorizations::Base

    private
    attr_reader :user, :trip, :housing

    public

    def initialize(user, trip, housing)
      @user    = user
      @trip    = trip
      @housing = housing
    end

    def granted?
      housing && no_existing_like? && trip && future_trip? && user_signed_in? && user_organizer?
    end

    private
    def no_existing_like?
      LikeRepository.new.find_for_user_and_housing(user.id, housing.id).nil?
    end
  end
end

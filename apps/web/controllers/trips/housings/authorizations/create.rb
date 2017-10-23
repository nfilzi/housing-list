module Web::Trips::Housings::Authorizations
  class Create
    include ::Web::Trips::Authorizations::Base

    private
    attr_reader :trip, :user

    public

    def initialize(user, trip)
      @user = user
      @trip = trip
    end

    def granted?
      trip && future_trip? && user_signed_in? && user_organizer?
    end
  end
end

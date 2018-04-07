module Web::Trips::Housings::Authorizations
  class Dismiss
    include ::Web::Trips::Authorizations::Base
    include ::Web::Trips::Housings::Authorizations::Base

    private
    attr_reader :housing, :trip, :user

    public

    def initialize(user, trip, housing)
      @user    = user
      @trip    = trip
      @housing = housing
    end

    def granted?
      trip && future_trip? && housing && housing_active? && user_signed_in? && user_organizer?
    end
  end
end

module Web::Trips::Housings::Authorizations
  class Update
    include ::Web::Trips::Authorizations::Base

    private
    attr_reader :housing, :trip, :user

    public

    def initialize(user, trip, housing)
      @user    = user
      @trip    = trip
      @housing = housing
    end

    def granted?
      trip && housing && future_trip? && user_signed_in? && user_organizer?
    end
  end
end

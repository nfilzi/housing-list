module Web::Trips::Authorizations
  class Join
    include Base

    private
    attr_reader :trip, :user

    public

    def initialize(user, trip)
      @user = user
      @trip = trip
    end

    def granted?
      visitor? || (user_signed_in? && !user_organizer?)
    end

    private

    def visitor?
      !user
    end
  end
end

module Web::Trips::Authorizations
  class Show
    include Base
    private
    attr_reader :token, :trip, :user

    public

    def initialize(user, trip, token=nil)
      @user  = user
      @token = token
      @trip  = trip
    end

    def granted?
      trip && (user_signed_in? && user_organizer?) || visitor_authorized?
    end

    private

    def visitor_authorized?
      !token.to_s.empty? && token == trip.invitation_token
    end
  end
end

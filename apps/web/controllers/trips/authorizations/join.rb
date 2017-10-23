module Web::Trips::Authorizations
  class Join
    include Base

    private
    attr_reader :token, :trip, :user

    public

    def initialize(user, trip, token)
      @user  = user
      @trip  = trip
      @token = token
    end

    def granted?
      token_valid? && (visitor? || (user_signed_in? && !user_organizer?))
    end

    private

    def token_valid?
      !token.to_s.empty? && token == trip.invitation_token
    end

    def visitor?
      !user
    end
  end
end

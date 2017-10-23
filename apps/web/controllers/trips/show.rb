module Web::Controllers::Trips
  class Show
    include Web::Action
    include Web::Users::SkipAuthentication

    before :load_trip
    before :authorize
    before :store_current_location
    before :store_invitation_token

    expose :authorization
    expose :housing_stats
    expose :housings
    expose :invitation_token
    expose :trip

    def call(params)
      @housings = HousingRepository.new.for_trip_sorted_by_most_recent(@trip.id)
    end

    private

    def load_trip
      @trip = TripRepository.new.find_with_stats(params[:id])
    end

    def authorize
      @authorization = Web::Trips::Authorization.new(current_user, trip)
      return if authorization.show?(params[:token])

      if !user_signed_in? && params[:token].nil?
        store_current_location
        redirect_to routes.user_sign_in_path
      else
        halt 404
      end
    end

    def store_invitation_token
      @invitation_token = params[:token]
      return unless @invitation_token

      session[:invitation_token] = @invitation_token
    end
  end
end

module Web::Controllers::Trips
  class Show
    include Web::Action
    include Web::Users::SkipAuthentication

    before :load_trip_and_authorize

    expose :housing_stats
    expose :housings
    expose :trip

    def call(params)
      @housings = HousingRepository.new.for_trip_sorted_by_most_recent(@trip.id)
    end

    private

    def load_trip_and_authorize
      @trip = TripRepository.new.find_with_stats(params[:id])
      halt 404 unless @trip && ((user_signed_in? && user_organizer?) || visitor_authorized?)
    end

    def user_organizer?
      TripOrganizerRepository.new.organizes_trip?(current_user.id, @trip.id)
    end

    def visitor_authorized?
      token = params[:token].to_s

      if !token.empty? && token == @trip.invitation_token
        session[:invitation_token] = params[:token]
        return true
      else
        return false
      end
    end
  end
end

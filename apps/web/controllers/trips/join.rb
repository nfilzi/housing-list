module Web::Controllers::Trips
  class Join
    include Web::Action

    before :load_trip
    before :authorize

    def call(params)
      TripOrganizerRepository.new.create(
        trip_id:      @trip.id,
        organizer_id: current_user.id
      )

      session[:invitation_token] = nil
      redirect_to routes.trip_path(@trip.id)
    end

    private

    def load_trip
      @trip = TripRepository.new.find(params[:id])
    end

    def authorize
      authorization = Web::Trips::Authorization.new(current_user, @trip)
      halt 401 unless authorization.join?(session[:invitation_token])
    end
  end
end

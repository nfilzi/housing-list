module Web::Controllers::Trips
  class Update
    include Web::Action

    before :load_trip
    before :authorize

    expose :trip

    params do
      required(:trip).schema do
        required(:destination).filled(:str?)
        required(:starting_on).filled(:date?)
        required(:ending_on).filled(:date?)
        required(:travelers_count).filled(:int?)
        optional(:background_picture).maybe
      end
    end

    def call(params)
      result = Trips::Update.new(@trip, params).call

      if result.successful?
        redirect_to routes.trip_path(result.trip.id)
      else
        self.status = 422
      end
    end

    private

    def load_trip
      @trip = TripRepository.new.find(params[:id])
    end

    def authorize
      authorization = Web::Trips::Authorization.new(current_user, trip)
      halt 404 unless authorization.edit?
    end
  end
end

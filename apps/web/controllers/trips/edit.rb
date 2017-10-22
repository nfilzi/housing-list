module Web::Controllers::Trips
  class Edit
    include Web::Action

    before :load_trip
    before :authorize

    expose :trip

    def call(params)
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

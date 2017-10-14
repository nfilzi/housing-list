require_relative 'authorization'

module Web::Controllers::Trips
  class Edit
    include Web::Action
    include Web::Trips::Authorization

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
      halt 404 unless user_organizer?
    end
  end
end

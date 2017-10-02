require_relative 'authorization'

module Web::Controllers::Trips
  class Show
    include Web::Action
    include Web::Users::SkipAuthentication
    include Web::Trips::Authorization

    before :load_trip
    before :authorize

    expose :housing_stats
    expose :housings
    expose :trip

    def call(params)
      @housings = HousingRepository.new.for_trip_sorted_by_most_recent(@trip.id)
    end

    private

    def load_trip
      @trip = TripRepository.new.find_with_stats(params[:id])
    end
  end
end

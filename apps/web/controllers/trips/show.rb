module Web::Controllers::Trips
  class Show
    include Web::Action

    expose :housing_stats
    expose :housings
    expose :trip

    def call(params)
      @trip          = TripRepository.new.find(params[:id])
      @housings      = HousingRepository.new.for_trip_sorted_by_most_recent(@trip.id)
      @housing_stats = HousingRepository.new.stats_for_trip(@trip.id)
    end
  end
end

module Web::Controllers::Trips
  class Show
    include Web::Action

    expose :housings
    expose :trip

    def call(params)
      @trip     = TripRepository.new.find(params[:id])
      @housings = HousingRepository.new.all_by_trip_with_user(@trip.id)
    end
  end
end

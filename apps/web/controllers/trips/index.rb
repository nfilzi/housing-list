module Web::Controllers::Trips
  class Index
    include Web::Action

    expose :trips_status
    expose :trips

    def call(params)
      @trips_status = (params[:status] || :future).to_sym
      @trips = TripRepository.new.all_for_organizer_by_status(current_user.id, @trips_status)
    end
  end
end

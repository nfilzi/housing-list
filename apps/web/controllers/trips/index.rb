module Web::Controllers::Trips
  class Index
    include Web::Action

    expose :trip_status
    expose :trips

    def call(params)
      @trip_status = (params[:status] || :future).to_sym
      @trips = TripRepository.new.all_for_organizer_by_status(current_user.id, @trip_status)
    end
  end
end

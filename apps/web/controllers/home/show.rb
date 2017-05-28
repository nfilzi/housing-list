module Web::Controllers::Home
  class Show
    include Web::Action

    expose :total_trips_count
    
    def call(params)
      @total_trips_count = TripRepository.new.count
    end
  end
end

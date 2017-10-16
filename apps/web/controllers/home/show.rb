module Web::Controllers::Home
  class Show
    include Web::Action
    include Web::Users::SkipAuthentication

    expose :supported_providers
    expose :total_trips_count

    def call(params)
      @supported_providers  = Housing::SUPPORTED_PROVIDERS
      @total_trips_count    = TripRepository.new.count
    end
  end
end

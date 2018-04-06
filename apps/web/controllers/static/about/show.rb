module Web::Controllers::Static
  module About
    class Show
      include Web::Action
      include Web::Users::SkipAuthentication

      expose :total_trips_count

      def call(params)
        @total_trips_count = TripRepository.new.count
      end
    end
  end
end

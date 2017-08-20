module Web::Controllers::Trips
  module Housings
    class New
      include Web::Action

      expose :trip

      def call(params)
        @trip = TripRepository.new.find(params[:trip_id])
      end
    end
  end
end

module Web::Controllers::Trips
  module Housings
    class New
      include Web::Action

      before :load_trip
      before :authorize

      expose :trip

      def call(params)
      end

      private

      def load_trip
        @trip = TripRepository.new.find(params[:trip_id])
      end

      def authorize
        authorization = Web::Trips::Housings::Authorization.new(current_user)
        halt 401 unless authorization.create?(@trip)
      end
    end
  end
end

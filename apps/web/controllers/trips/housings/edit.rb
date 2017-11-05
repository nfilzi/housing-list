module Web::Controllers::Trips
  module Housings
    class Edit
      include Web::Action

      before :load_trip
      before :load_housing
      before :authorize

      expose :trip
      expose :housing

      def call(params)
      end

      private

      def load_trip
        @trip = TripRepository.new.find(params[:trip_id])
      end

      def load_housing
        @housing = HousingRepository.new.find_for_trip(params[:id], params[:trip_id])
      end

      def authorize
        authorization = Web::Trips::Housings::Authorization.new(current_user, @trip, @housing)
        halt 401 unless authorization.edit?
      end
    end
  end
end

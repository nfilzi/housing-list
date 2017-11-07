module Web::Controllers::Trips
  module Housings
    class Dismiss
      include Web::Action

      before :load_trip
      before :load_housing
      before :authorize

      def call(params)
        HousingRepository.new.update(@housing.id, dismissed: true)
        redirect_to routes.trip_path(@trip.id)
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
        halt 401 unless authorization.dismiss?
      end
    end
  end
end

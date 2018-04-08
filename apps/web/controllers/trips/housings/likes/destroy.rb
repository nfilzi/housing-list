module Web::Controllers::Trips::Housings
  module Likes
    class Destroy
      include Web::Action

      before :load_trip
      before :load_housing
      before :authorize

      def call(params)
        ::Likes::Destroy.new(current_user, @housing).call
        redirect_to routes.trip_path(@trip.id)
      end

      private
      def load_trip
        @trip = TripRepository.new.find(params[:trip_id])
      end

      def load_housing
        @housing = HousingRepository.new.find(params[:housing_id])
      end

      def authorize
        authorization = Web::Trips::Housings::Likes::Authorization.new(current_user, @trip, @housing)
        halt 401 unless authorization.destroy?
      end
    end
  end
end

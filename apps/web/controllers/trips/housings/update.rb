module Web::Controllers::Trips
  module Housings
    class Update
      include Web::Action

      before :load_trip
      before :load_housing
      before :authorize

      expose :trip
      expose :housing

      params do
        required(:housing).schema do
          required(:title).filled(:str?)
          required(:description).filled(:str?)
          required(:total_price).filled(:int?)
        end
      end

      def call(params)
        if params.valid?
          HousingRepository.new.update(housing.id, params[:housing])
          redirect_to routes.trip_path(trip.id)
        else
          self.status = 422
        end
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

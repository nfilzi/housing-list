module Web::Controllers::Trips
  module Housings
    class Create
      include Web::Action

      before :load_trip
      before :authorize

      expose :error
      expose :supported_providers
      expose :trip

      params do
        required(:housing).schema do
          required(:url).filled(:str?)
        end
      end

      def call(params)
        result = ::Housings::Create.new(current_user, @trip, params).call

        if result.successful?
          redirect_to routes.trip_path(@trip.id)
        else
          @error               = result.error
          @supported_providers = Housing::SUPPORTED_PROVIDERS

          self.status = 422
        end
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

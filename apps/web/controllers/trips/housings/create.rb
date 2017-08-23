require_relative 'authorization'

module Web::Controllers::Trips
  module Housings
    class Create
      include Web::Action
      include Web::Trips::Housings::Authorization

      before :load_trip_and_authorize

      expose :trip

      params do
        required(:housing).schema do
          required(:url).filled(:str?)
        end
      end

      def call(params)
        result = ::Housings::Create.new(current_user, @trip, params).call

        if result.successful?
          session[:invitation_token] = nil
          redirect_to routes.trip_path(@trip.id)
        else
          self.status = 422
        end
      end
    end
  end
end

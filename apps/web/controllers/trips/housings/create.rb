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
        if params.valid?
          housing = HousingRepository.new.create(housing_params)
          set_user_as_organizer

          redirect_to routes.trip_path(@trip.id)
        else
          self.status = 422
        end
      end

      private

      # TODO: move in an interactor
      def housing_params
        params[:housing].merge(
          trip_id:  params[:trip_id],
          user_id:  current_user.id,
          provider: extract_provider
        )
      end

      def extract_provider
        url            = params.dig(:housing, :url)
        provider_regex = /\Ahttps?:\/\/www\.(?<provider>airbnb|booking)\.[a-z]+/
        match_data     = url.match(provider_regex)

        match_data ? match_data[:provider] : 'n/a'
      end

      def set_user_as_organizer
        return if user_organizer?

        TripOrganizerRepository.new.create(organizer_id: current_user.id, trip_id: @trip.id)
        session[:invitation_token] = nil
      end
    end
  end
end

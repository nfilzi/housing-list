module Web::Controllers::Trips
  module Housings
    class Create
      include Web::Action

      expose :trip

      params do
        required(:housing).schema do
          required(:url).filled(:str?)
        end
      end

      def call(params)
        @trip = TripRepository.new.find(params[:trip_id])

        if params.valid?
          housing = HousingRepository.new.create(housing_params)

          redirect_to routes.trip_path(@trip.id)
        else
          self.status = 422
        end
      end

      private

      def housing_params
        params[:housing].merge(
          trip_id:  params[:trip_id],
          user_id:  UserRepository.new.all.first.id, # FIXME
          provider: extract_provider
        )
      end

      def extract_provider
        url            = params.dig(:housing, :url)
        provider_regex = /\Ahttps?:\/\/www\.(?<provider>airbnb|booking)\.[a-z]+/
        match_data     = url.match(provider_regex)

        match_data ? match_data[:provider] : 'n/a'
      end
    end
  end
end

require 'securerandom'

module Web::Controllers::Trips
  class Create
    include Web::Action

    params do
      required(:trip).schema do
        required(:destination).filled(:str?)
        required(:starting_on).filled(:date?)
        required(:ending_on).filled(:date?)
        required(:travelers_count).filled(:int?)
      end
    end

    def call(params)
      result = ::Trips::Create.new(current_user, params).call
      if result.successful?
        redirect_to routes.trip_path(trip.id)
      else
        self.status = 422
      end
    end

    private

    def trip_params
      params[:trip].merge(
        trip_organizers: [organizer_id: current_user.id],
        invitation_token: SecureRandom.hex[0, 8].upcase
      )
    end
  end
end

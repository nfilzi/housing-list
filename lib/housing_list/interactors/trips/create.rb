require 'hanami/interactor'

module Trips
  class Create
    include Hanami::Interactor
    expose :trip

    private
    attr_reader :user, :trip, :params

    public
    def initialize(user, params)
      @user   = user
      @params = params
    end

    def call
      @trip     = TripRepository.new.create_with_organizer(trip_params)

      # Can't access tempfile of filepath through params[:trip][:background_picture]
      # Can't know why yet
      filepath  = params.env["rack.request.form_hash"]["trip"]["background_picture"][:tempfile].path
      uc_file   = ::Uploaders::Picture.new(filepath).call
      TripRepository.new.update(@trip.id, picture_uuid: uc_file.uuid)
    end

    private

    def valid?
      params.valid?
    end

    def trip_params
      params[:trip].merge(
        trip_organizers: [organizer_id: user.id],
        invitation_token: SecureRandom.hex[0, 8].upcase
      )
    end
  end
end

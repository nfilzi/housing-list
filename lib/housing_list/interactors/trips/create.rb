require 'hanami/interactor'

require_relative '../../../file_uploader'

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
      @trip = TripRepository.new.create_with_organizer(trip_params)
      upload_picture_and_update_trip
    end

    private

    def upload_picture_and_update_trip
      return unless params[:trip][:background_picture]

      filepath = params[:trip][:background_picture][:tempfile]
      uc_file  = FileUploader.call(filepath)

      TripRepository.new.update(@trip.id, picture_uuid: uc_file.uuid)
    end

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

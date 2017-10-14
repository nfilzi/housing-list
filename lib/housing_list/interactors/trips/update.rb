require 'hanami/interactor'

module Trips
  class Update
    include Hanami::Interactor

    expose :trip

    private
    attr_reader :trip, :params

    public

    def initialize(trip, params)
      @trip   = trip
      @params = params
    end

    def call
      picture_uuid = upload_new_picture_and_delete_old_one
      @trip = TripRepository.new.update(trip.id, trip_params(picture_uuid))
    end

    private

    def trip_params(picture_uuid)
      params[:trip].merge(picture_uuid: picture_uuid)
    end

    def upload_new_picture_and_delete_old_one
      return unless params[:trip][:background_picture]

      # TODO: enqueue async job instead
      FileRemover.call(trip.picture_uuid) if trip.picture_uuid

      filepath = params[:trip][:background_picture][:tempfile]
      uc_file  = FileUploader.call(filepath)

      return uc_file.uuid
    end

    def valid?
      params.valid?
    end
  end
end

require "hanami/interactor"

module Trips
  class FetchRandomPicture
    include Hanami::Interactor

    private
    attr_reader :trip

    public
    def initialize(trip)
      @trip = trip
    end

    def call
      return if trip.picture_uuid

      picture_url = find_random_picture_url
      return unless picture_url

      picture_uuid = upload_picture(picture_url)
      TripRepository.new.update(trip.id, picture_uuid: picture_uuid)
    end

    private

    def find_random_picture_url
      return RandomPicture.find(trip.destination)
    end

    def upload_picture(picture_url)
      uc_file = RemoteFileUploader.call(picture_url)
      return uc_file.uuid
    end
  end
end

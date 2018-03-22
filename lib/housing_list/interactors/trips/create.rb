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
      @trip = TripRepository.new.create_with_organizer(trip_params)
      Trips::SetRandomPicture.new(trip).call
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

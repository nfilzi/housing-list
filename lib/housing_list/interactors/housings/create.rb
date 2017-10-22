require 'hanami/interactor'

module Housings
  class Create
    include Hanami::Interactor
    expose :housing

    private
    attr_reader :user, :trip, :params, :housing

    public
    def initialize(user, trip, params)
      @user   = user
      @trip   = trip
      @params = params
    end

    def call
      @housing = HousingRepository.new.create(housing_params)
      set_user_as_organizer
      Housings::FetchDetailsAndUpdateWorker.perform_async(housing.id)
    end

    private

    def set_user_as_organizer
      return if user_organizer?
      TripOrganizerRepository.organizes_trip?(user.id, trip.id)
    end

    def user_organizer?
      trip.trip_organizers.any? { |organizer| organizer.organizer_id == user.id }
    end

    def valid?
      params.valid?
    end

    def housing_params
      params[:housing].merge(
        trip_id:  trip.id,
        user_id:  user.id,
        provider: extract_provider
      )
    end

    def extract_provider
      url            = params.dig(:housing, :url)
      provider_regex = /\Ahttps?:\/\/(www|secure)\.(?<provider>airbnb|booking)\.[a-z]+/
      match_data     = url.match(provider_regex)

      match_data ? match_data[:provider] : 'n/a'
    end
  end
end

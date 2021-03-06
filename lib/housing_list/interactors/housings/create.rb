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
      Housings::FetchDetailsAndUpdateWorker.perform_async(housing.id)
    end

    private

    def valid?
      valid_params? && valid_provider?
    end

    def housing_params
      params[:housing].merge(
        url:      patched_url,
        trip_id:  trip.id,
        user_id:  user.id,
        provider: provider
      )
    end

    def provider
      return @provider if defined?(@provider)

      url            = params.dig(:housing, :url)
      provider_regex = /\Ahttps?:\/\/(www|secure)\.(?<provider>airbnb|booking)\.[a-z]+/
      match_data     = url.match(provider_regex)

      @provider = match_data[:provider] if match_data
    end

    def provider_supported?
      Housing::SUPPORTED_PROVIDERS.include?(provider)
    end

    def patched_url
      uri    = URI.parse(params.dig(:housing, :url))
      query  = uri.query || ''
      params = URI.decode_www_form(query).to_h

      params['check_in']  ||= trip.starting_on.strftime('%Y-%m-%d')
      params['check_out'] ||= trip.ending_on.strftime('%Y-%m-%d')
      params['adults']    ||= trip.travelers_count

      return "https://#{uri.hostname}#{uri.path}?#{URI.encode_www_form(params)}"
    end

    def valid_params?
      return true if params.valid?

      error(:invalid_params)
      return false
    end

    def valid_provider?
      return true if provider_supported?

      error(:invalid_provider)
      return false
    end
  end
end

require "hanami/interactor"

module Housings
  def self.supported_providers
    # could be defined in a housings/supported_providers.rb file?
    {
      "airbnb" => ::Housings::Airbnb,
      # "booking" => ::Housings::Booking,
    }
  end

  class UpdateWithScrapedData
    include Hanami::Interactor
    expose :housing

    private
    attr_reader :housing

    public
    def initialize(housing)
      @housing = housing
    end

    def call
      provider_class  = Housings.supported_providers[housing.provider]
      result          = provider_class::Scraper.new(url: housing.url, ).call
      # Mocking for quick test
      # data = {title: "fu", description: "foo", total_price: 2031, airbnb_id: 16120954, picture_url: "https://a0.muscache.com/im/pictures/70d0b78e-f5ef-425d-82a5-aafa67f3359999.jpg?aki_policy=xx_large"}
      HousingRepository.new.update(housing.id, result.data)
    end
  end
end

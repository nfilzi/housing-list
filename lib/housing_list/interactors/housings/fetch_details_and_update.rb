require "hanami/interactor"

module Housings
  class FetchDetailsAndUpdate
    include Hanami::Interactor
    expose :housing

    private
    attr_reader :housing

    public
    def initialize(housing)
      @housing = housing
    end

    def call
      provider_name       = housing.provider.split('_').map(&:capitalize).join
      scraper_class_name  = "Scrapers::#{provider_name}::Housing"
      scraper_class       = Object.const_get(scraper_class_name)
      housing_attributes  = scraper_class.new(url: housing.url).scrape

      HousingRepository.new.update(housing.id, housing_attributes.merge(imported: true))
    end
  end
end

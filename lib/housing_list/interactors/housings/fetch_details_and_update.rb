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
      scraper_class_name  = "Housings::Scrapers::#{provider_name}"
      scraper_class       = Object.const_get(provider_class_name)
      result              = scraper_class.new(url: housing.url).call

      HousingRepository.new.update(housing.id, result.housing_attributes.merge(imported: true))
    end
  end
end

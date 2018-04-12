module Providers
  class SearchURL
    def self.generate(provider, parameters)
      provider_name          = provider.split('_').map(&:capitalize).join
      search_url_class_name  = "Providers::#{provider_name}::SearchURL"
      search_url_class       = Object.const_get(search_url_class_name)

      return search_url_class.generate(parameters)
    end
  end
end

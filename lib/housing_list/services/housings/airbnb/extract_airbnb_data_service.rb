module Housings
  module Airbnb
    class ExtractDataService
      def initialize(url:)
        @url = url
      end

      def call
        provider = { provider: extract_provider }
        data = extract_data
        # binding.pry
        data.merge(provider)
      end

      private

      def extract_data
        init_capybara
        browser = Capybara.current_session
        browser.visit @url
        total_price       = browser.find(".book-it__subtotal table tbody tr:last-child .text-right span span").text.gsub("€", "").to_i
        price_per_night   = browser.find(".book-it__container .book-it__price .book-it__price-amount #book-it-price-string").text.gsub("€", "").to_i

        return {
          total_price: total_price,
          price_per_night: price_per_night
        }
      end

      def extract_provider
        provider_regex = /\Ahttps?:\/\/www\.(?<provider>airbnb|booking)\.[a-z]+/
        match_data     = @url.match(provider_regex)

        match_data ? match_data[:provider] : 'n/a'
      end

      def init_capybara
        require 'capybara/poltergeist'
        Capybara.register_driver :poltergeist do |app|
          Capybara::Poltergeist::Driver.new(app, js_errors: false)
        end

        Capybara.default_driver = :poltergeist
      end
    end
  end
end

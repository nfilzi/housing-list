require 'hanami/interactor'

module Housings
  module Airbnb
    class Scraper
      include Hanami::Interactor
      expose :data

      private
      attr_reader :url, :browser

      public
      def initialize(url:)
        @url = url
        init_capybara
        @browser = Capybara.current_session
        browser.visit(housing_url_with_currency)
      end

      def call
        housing_full_airbnb_data = extract_housing_data_from_embedded_json
        @data                    = extract_housing_data(housing_full_airbnb_data)
      end

      private

      def housing_url_with_currency
        url + "&currency=#{find_currency}"
      end

      def find_currency
        # We can add &currency=#{currency} to housing url query string to get euro price for now
        # when currency will be added to trip
        # housing.trip.currency || "EUR"
        "EUR"
      end

      def extract_housing_data(data)
        sleep 1 # Keeps finding multiple elements with the below selector without this 😱
        total_price = browser.find(".book-it__subtotal table tbody tr:last-child").text.gsub(/[^\d]/, "").to_i
        return {
          title: data["name"],
          description: data["description"],
          total_price: total_price,
          airbnb_id: data["id"],
          picture_url: data["photos"].first["large"],
          raw_data_blob: data
        }
      end

      def extract_housing_data_from_embedded_json
        raw_data = browser.all("body script", visible: false)[5].text(:all)
        JSON.parse(raw_data[4..-4])["bootstrapData"]["reduxData"]["marketplacePdp"]["listingInfo"]["listing"]
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

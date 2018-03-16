module Scrapers
  module Airbnb
    class Housing
      private
      attr_reader :url, :browser

      public

      def initialize(url:)
        @url = url
      end

      def scrape
        init_capybara
        @browser = Capybara.current_session

        # To get the desktop version for the scraped page, in order to get access
        # to the flat booking form
        browser.driver.resize(3072, 2304)

        browser.visit(url_with_currency)

        return build_housing_attributes
      end

      private

      def url_with_currency
        url + "&currency=#{find_currency}"
      end

      def find_currency
        # We can add &currency=#{currency} to housing url query string to get euro price for now
        # when currency will be added to trip
        # housing.trip.currency || "EUR"
        "EUR"
      end

      def build_housing_attributes
        data = extract_airbnb_housing_data
        total_price = browser.find("#book_it_form").text.match(/Total .(\d+)/)[1].to_i

        return {
          title:       data["sectioned_description"]["name"],
          description: data["sectioned_description"]["description"],
          total_price: total_price,
          provider_id: data["id"],
          picture_url: data["photos"].first["large"],
          raw_data:    data
        }
      end

      def extract_airbnb_housing_data
        raw_data = browser.all("body script", visible: false)[5].text(:all)
        JSON.parse(raw_data[4..-4])["bootstrapData"]["reduxData"]["homePDP"]["listingInfo"]["listing"]
      end

      def init_capybara
        require 'capybara/poltergeist'
        Capybara.register_driver :poltergeist do |app|
          Capybara::Poltergeist::Driver.new(app, phantomjs: Phantomjs.path, js_errors: false)
        end

        Capybara.default_driver = :poltergeist

        # To debug with a real browser, if needed
        # Capybara.register_driver :selenium do |app|
        #   Capybara::Selenium::Driver.new(app, browser: :chrome)
        # end

        # Capybara.javascript_driver = :chrome

        # Capybara.configure do |config|
        #   config.default_max_wait_time = 10 # seconds
        #   config.default_driver        = :selenium
        # end
      end
    end
  end
end

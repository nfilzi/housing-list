module Scrapers
  class Airbnb
    private
    attr_reader :url, :browser

    public

    def initialize(url:)
      @url = url
    end

    def scrape
      init_capybara
      @browser = Capybara.current_session
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
      sleep 1 # Keeps finding multiple elements with the below selector without this 😱
      data                  = extract_airbnb_housing_data
      total_price_selector  = ".book-it__subtotal table tbody tr:last-child"
      total_price           = browser.find(total_price_selector).text.gsub(/[^\d]/, "").to_i

      return {
        title:       data["name"],
        description: data["description"],
        total_price: total_price,
        provider_id: data["id"],
        picture_url: data["photos"].first["large"],
        raw_data:    data
      }
    end

    def extract_airbnb_housing_data
      raw_data = browser.all("body script", visible: false)[5].text(:all)
      JSON.parse(raw_data[4..-4])["bootstrapData"]["reduxData"]["marketplacePdp"]["listingInfo"]["listing"]
    end

    def init_capybara
      require 'capybara/poltergeist'
      Capybara.register_driver :poltergeist do |app|
        Capybara::Poltergeist::Driver.new(app, phantomjs: Phantomjs.path, js_errors: false)
      end

      Capybara.default_driver = :poltergeist
    end
  end
end

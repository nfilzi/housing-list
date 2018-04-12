module Providers
  module Booking
    module Scrapers
      class Reservation
        private
        attr_reader :url, :browser

        public

        def initialize(url:)
          @url = url
        end

        def scrape
          init_capybara
          @browser = Capybara.current_session
          browser.visit(url)

          return build_reservation_attributes
        end

        private

        def build_reservation_attributes
          data      = extract_reservation_data
          hotel_id  = extract_hotel_id
          hotel_url = extract_hotel_url

          return {
            reservation: data,
            hotel: {
              id: hotel_id,
              url: hotel_url
            }
          }
        end

        def extract_reservation_data
          total_price, currency_code = extract_total_price_with_currency_code
          {
            total_price:        total_price,
            currency_code:      currency_code,
            rooms_arrangement:  extract_rooms_arrangement
          }
        end

        def extract_hotel_url
          hotel_url_link_selector = '.bp_modify_selection__link--from_hotel'
          hotel_url_link          = browser.find(hotel_url_link_selector)

          return hotel_url_link["href"]
        end

        def extract_total_price_with_currency_code
          total_price_selector  = '.bp_pricedetails_total .bp_pricedetails_total_value'
          total_price_span      = browser.find(total_price_selector)
          total_price           = total_price_span["data-price"].to_i
          currency_code         = total_price_span["data-currency-code"]

          return [total_price, currency_code]
        end

        def extract_rooms_arrangement
          rooms_arrangement_selector    = '.bp_sidebar_content_block__li--rooms .bp_sidebar_content_block__li_content'
          rooms_arrangement_divs        = browser.all(rooms_arrangement_selector)

          return rooms_arrangement_divs.map { |div| div.text }
        end

        def extract_hotel_id
          reservation_uri = URI.parse(url)
          query_hash      = Rack::Utils.parse_query(reservation_uri.query)

          return query_hash["hotel_id"].to_i
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
  end
end

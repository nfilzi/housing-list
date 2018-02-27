module Scrapers
  module Booking
    class Hotel
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

        return build_hotel_attributes
      end

      private

      def build_hotel_attributes
        data     = extract_hotel_data
        raw_data = extract_raw_data
        hotel_id = raw_data.delete(:hotel_id)

        return {
          title:       data[:title],
          description: data[:description],
          provider_id: hotel_id,
          picture_url: data[:picture_url],
          raw_data:    raw_data
        }
      end

      def extract_hotel_data
        title_selector  = ".hp__hotel-name"
        title           = browser.find(title_selector).text.strip

        description_selector  = ".hp-description .hp_desc_main_content #summary p"
        description           = browser.all(description_selector).map(&:text).map(&:strip).join("\n").strip

        pictures_selector = ".bh-photo-grid .active-image"
        pictures_links    = browser.all(pictures_selector)
        picture_url       = pictures_links.first["href"]

        {
          title:       title,
          description: description,
          picture_url: picture_url
        }
      end

      def extract_raw_data
        scripts = browser.all("head script", visible: false)

        basic_raw_data = JSON.parse(scripts[9]["innerHTML"].gsub("\n", ""))

        hotel_id_regexp = /b_hotel_id:\s'(?<hotel_id>\d+)'/
        hotel_id = scripts[10]["innerHTML"].match(hotel_id_regexp)[:hotel_id].to_i

        return basic_raw_data.merge(hotel_id: hotel_id)
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

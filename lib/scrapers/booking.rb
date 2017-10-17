module Scrapers
  module Booking
    class Hotel
      private
      attr_reader :url, :browser

      public

      def initialize(url:)
        # TO KEEP => Test url: "https://www.booking.com/hotel/jp/flexstayshirogane.html?aid=304142;label=gen173nr-1FCAEoggJCAlhYSDNiBW5vcmVmaE2IAQGYATG4AQfIAQzYAQHoAQH4AQKSAgF5qAID;sid=0dcdfab44b9cce7749eaf5e3c6ec1d87;atlas_src=sr_iw_title;checkin=2017-12-06;checkout=2017-12-29;dist=0;group_adults=2;room1=A%2CA;sb_price_type=total;srepoch=1508275314;srpvid=20ab95ae89bb0081;type=total&"
        @url = url
      end

      def scrape
        init_capybara
        @browser = Capybara.current_session
        browser.visit(url)

        return build_housing_attributes
      end

      private

      def build_housing_attributes
        data        = extract_housing_data
        raw_data    = extract_raw_data
        housing_id  = raw_data.delete(:housing_id)

        return {
          title:       data[:title],
          description: data[:description],
          provider_id: housing_id,
          picture_url: data[:picture_url],
          raw_data:    raw_data
        }
      end

      def extract_housing_data
        title_selector  = ".hp__hotel-name"
        title           = browser.find(title_selector).text.strip

        description_selector  = ".hp-description .hp_desc_main_content #summary p"
        description           = browser.all(description_selector).map(&:text).map(&:strip).join("\n").strip

        slider_selector = ".hp-gallery .slick-slider .slick-track"
        slider_div      = browser.find(slider_selector)
        picture_url = slider_div.all("div.slick-slide img").first["src"].strip

        {
          title:       title,
          description: description,
          picture_url: picture_url
        }
      end

      def extract_raw_data
        scripts = browser.all("head script", visible: false)

        basic_raw_data = JSON.parse(scripts[9]["innerHTML"].gsub("\n", ""))

        housing_id_regexp = /b_hotel_id:\s'(?<housing_id>\d+)'/
        housing_id = scripts[10]["innerHTML"].match(housing_id_regexp)[:housing_id].to_i

        return basic_raw_data.merge(housing_id: housing_id)
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

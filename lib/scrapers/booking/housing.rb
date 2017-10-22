module Scrapers
  module Booking
    class Housing
      private
      attr_reader :url, :hotel_attributes

      public

      def initialize(url:)
        @url = url
      end

      def scrape
        if has_reservation_url?
          build_reservation_attributes
          housing_url = reservation_attributes[:housing][:url]
          build_hotel_attributes(housing_url)
        else
          build_hotel_attributes(url)
        end

        build_housing_attributes
      end

      private
      def build_housing_attributes
        total_price     = reservation_attributes.dig(:reservation, :total_price) || 0
        housing_url     = reservation_attributes.dig(:housing, :url) || url
        reservation_url = has_reservation_url? ? url : nil

        hotel_attributes.merge(
          total_price:      total_price,
          url:              housing_url,
          reservation_url:  reservation_url
        )
      end

      def has_reservation_url?
        regex       = /\Ahttps?:\/\/(?<subdomain>www|secure)\.(?<provider>airbnb|booking)\.[a-z]+/
        match_data  = url.match(regex)

        match_data[:subdomain] == "secure"
      end

      def build_reservation_attributes
        @reservation_attributes = ::Scrapers::Booking::Reservation.new(url: url).scrape
      end

      def build_hotel_attributes(housing_url)
        @hotel_attributes = ::Scrapers::Booking::Hotel.new(url: housing_url).scrape
      end

      def reservation_attributes
        @reservation_attributes ||= {}
      end
    end
  end
end

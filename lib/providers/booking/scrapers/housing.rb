module Providers
  module Booking
    module Scrapers
      class Housing
        private
        attr_reader :base_url, :hotel_url, :hotel_attributes

        public

        def initialize(url:)
          @base_url = url
        end

        def scrape
          if has_reservation_url?
            build_reservation_attributes(base_url)

            @hotel_url = reservation_attributes[:hotel][:url]
          else
            @hotel_url = base_url
          end

          build_hotel_attributes
          build_housing_attributes
        end

        private

        def build_housing_attributes
          total_price = reservation_attributes.dig(:reservation, :total_price)

          hotel_attributes.merge(
            total_price: total_price,
            url:         hotel_url
          )
        end

        def has_reservation_url?
          /\Ahttps?:\/\/secure\.booking\.[a-z]+/ === base_url
        end

        def build_reservation_attributes(reservation_url)
          @reservation_attributes = ::Providers::Booking::Scrapers::Reservation.new(url: reservation_url).scrape
        end

        def build_hotel_attributes
          @hotel_attributes = ::Providers::Booking::Scrapers::Hotel.new(url: hotel_url).scrape
        end

        def reservation_attributes
          @reservation_attributes ||= {}
        end
      end
    end
  end
end

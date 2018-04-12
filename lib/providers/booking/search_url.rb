module Providers
  module Booking
    class SearchURL
      def self.generate(destination:, travelers_count:, starting_on:, ending_on:)
        params = {
          sb:                1, # mandatory
          ss:                destination,
          checkin_monthday:  starting_on.day,
          checkin_month:     starting_on.month,
          checkin_year:      starting_on.year,
          checkout_monthday: ending_on.day,
          checkout_month:    ending_on.month,
          checkout_year:     ending_on.year,
          group_adults:      travelers_count
        }

        return "https://www.booking.com/searchresults.html?#{URI.encode_www_form(params)}"
      end
    end
  end
end

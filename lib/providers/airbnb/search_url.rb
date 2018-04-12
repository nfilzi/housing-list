module Providers
  module Airbnb
    class SearchURL
      def self.generate(destination:, travelers_count:, starting_on:, ending_on:)
        params = {
          query:    destination,
          checkin:  starting_on.strftime('%Y-%m-%d'),
          checkout: ending_on.strftime('%Y-%m-%d'),
          adults:   travelers_count
        }

        return "https://www.airbnb.com/s/homes?#{URI.encode_www_form(params)}"
      end
    end
  end
end

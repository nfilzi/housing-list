module Web
  module Helpers
    module Housings
      def housing_total_price_per_person(trip, housing)
        (housing.total_price / trip.travelers_count).to_i
      end
    end
  end
end

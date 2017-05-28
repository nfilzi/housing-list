require 'forwardable'

module Web::Views::Trips
  class Show
    extend Forwardable
    include Web::View
    include Web::Helpers::DateFormatter
    include Web::Helpers::TextFormatter

    def_delegators :housing_stats, :housings_count
    def_delegators :housing_stats, :total_price_avg
    def_delegators :housing_stats, :total_price_min
    def_delegators :housing_stats, :total_price_max

    def days_before_trip
      (trip.starting_on - Date.today).to_i
    end

    def format_trip_date(date)
      format_date(date, format: '%b %e', ordinal_indicator: true)
    end

    def housing_total_price_per_person(housing)
      (housing.total_price / trip.travelers_count).to_i
    end

    def trip_not_started?
      Date.today < trip.starting_on
    end
  end
end

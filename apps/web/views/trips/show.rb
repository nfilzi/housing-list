require 'forwardable'

module Web::Views::Trips
  class Show
    extend Forwardable
    include Web::View
    include Web::Helpers::DateFormatter
    include Web::Helpers::TextFormatter
    include Web::Helpers::Housings
    include Web::Helpers::TripStatusMessages

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

    def housing_card_partial(housing)
      case
      when housing_pending?(housing)
        :housing_card_pending
      else
        :housing_card
      end
    end

    def trip_status
      return unless trip_to_come?

      if has_housings?
        few_days_left_message(days_before_trip)
      else
        create_a_housing_message
      end
    end

    private

    def housing_pending?(housing)
      housing.total_price == nil
    end

    def has_housings?
      housings_count >= 1
    end

    def trip_to_come?
      Date.today < trip.starting_on
    end
  end
end

module Web::Views::Trips
  class Index
    include Web::View
    include Web::Helpers::DateFormatter

    def days_before_trip(trip)
      (trip.starting_on - Date.today).to_i
    end

    def format_trip_date(date)
      format_date(date, format: '%b %e', ordinal_indicator: true)
    end

    def total_price_avg_per_person(trip)
      (trip.total_price_avg / trip.travelers_count).to_i
    end
  end
end

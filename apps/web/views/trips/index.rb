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
  end
end

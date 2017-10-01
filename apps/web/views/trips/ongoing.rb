module Web::Views::Trips
  class Ongoing
    include Web::View
    include Web::Helpers::DateFormatter

    template 'trips/index'

    def days_before_trip(trip)
      (trip.starting_on - Date.today).to_i
    end

    def format_trip_date(date)
      format_date(date, format: '%b %e', ordinal_indicator: true)
    end
  end
end

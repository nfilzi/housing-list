require 'forwardable'
require_relative '../../presenters/housing_presenter'
require_relative '../../presenters/trip_presenter'

module Web::Views::Trips
  class Show
    extend Forwardable
    include Web::View
    include Web::Helpers::DateFormatter
    include Web::Helpers::TextFormatter
    include Web::Helpers::TripStatusMessages

    def housings
      locals[:housings].map { |housing| HousingPresenter.new(housing) }
    end

    def trip
      TripPresenter.new(locals[:trip])
    end

    def after_js
      javascript('copy-invitation-link', async: true)
    end

    def trip_status_message
      case
      when trip.future?
        future_trip_message(trip)
      when trip.ongoing?
        ongoing_trip_message
      when trip.completed?
        completed_trip_message
      end
    end
  end
end

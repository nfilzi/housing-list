require 'forwardable'
require_relative '../../presenters/housing_presenter'
require_relative '../../presenters/trip_presenter'

module Web::Views::Trips
  class Show
    extend Forwardable
    include Web::View
    include Web::Helpers::DateFormatter
    include Web::Helpers::TextFormatter

    def housings
      locals[:housings].map { |housing| HousingPresenter.new(housing) }
    end

    def trip
      TripPresenter.new(locals[:trip])
    end

    def after_js
      javascript('copy-invitation-link', async: true)
    end
  end
end

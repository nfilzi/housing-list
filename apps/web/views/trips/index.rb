require_relative '../../presenters/trip_presenter'

module Web::Views::Trips
  class Index
    include Web::View

    def trips
      locals[:trips].map { |trip| TripPresenter.new(trip) }
    end
  end
end

require_relative '../../presenters/trip_presenter'

module Web::Views::Trips
  class Edit
    include Web::View

    def trip
      TripPresenter.new(locals[:trip])
    end
  end
end

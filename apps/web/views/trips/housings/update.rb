module Web::Views::Trips
  module Housings
    class Update
      include Web::View
      template 'trips/housings/edit'

      def trip
        TripPresenter.new(locals[:trip])
      end
    end
  end
end

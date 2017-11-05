module Web::Views::Trips
  module Housings
    class Edit
      include Web::View

      def trip
        TripPresenter.new(locals[:trip])
      end
    end
  end
end

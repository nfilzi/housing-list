module Web::Views::Trips
  module Housings
    class Create
      include Web::View
      template 'trips/housings/new'

      def after_js
        javascript('display-booking-info-box', async: true)
      end
    end
  end
end

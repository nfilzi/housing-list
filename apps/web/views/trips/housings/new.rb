module Web::Views::Trips
  module Housings
    class New
      include Web::View

      def after_js
        javascript('display-booking-info-box', async: true)
      end
    end
  end
end

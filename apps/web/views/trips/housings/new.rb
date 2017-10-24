module Web::Views::Trips
  module Housings
    class New
      include Web::View

      def error
        # no error when loading the page
      end

      def after_js
        javascript('display-booking-info-box', async: true)
      end
    end
  end
end

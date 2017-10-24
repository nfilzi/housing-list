module Web::Views::Trips
  module Housings
    class Create
      include Web::View
      template 'trips/housings/new'

      def error_message
        case error
        when :invalid_params
          'You forgot to provide the housing URL'
        when :invalid_provider
          providers = Housing::SUPPORTED_PROVIDERS.join(', ')

          message = 'This is not a valid provider. <br/>'
          message << "Choose one among the following: #{providers}."

          raw message
        else
          'Unable to create the housing. Try again.'
        end
      end

      def after_js
        javascript('display-booking-info-box', async: true)
      end
    end
  end
end

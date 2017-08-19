module Web
  module Helpers
    module TripStatusMessages
      def create_a_housing_message
        html.p(class: 'trip-status') do
          span   '👆', class: 'icon'
          text   "Let's create"
          strong 'your first housing!'
        end
      end

      def few_days_left_message(days_before_trip)
        html.p(class: 'trip-status') do
          text    'Only'
          strong  "#{days_before_trip} days left"
          text    "to find some place to stay at!"
        end
      end
    end
  end
end

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

      def running_trip_message
        html.p(class: 'trip-status') do
          text    'Time to'
          strong  "enjoy"
          text    "this trip!"
        end
      end

      def finished_trip_message
        html.p(class: 'trip-status') do
          text    'Hope you'
          strong  "enjoyed"
          text    "this trip!"
        end
      end
    end
  end
end

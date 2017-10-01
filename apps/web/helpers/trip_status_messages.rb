module Web
  module Helpers
    module TripStatusMessages
      def completed_trip_message
        html.p(class: 'trip-status') do
          text    'Hope you'
          strong  "enjoyed"
          text    "this trip!"
        end
      end

      def create_a_housing_message
        html.p(class: 'trip-status') do
          span   '👆', class: 'icon'
          text   "Let's create"
          strong 'your first housing!'
        end
      end

      def few_days_left_message(days_before_beginning)
        html.p(class: 'trip-status') do
          text    'Only'
          strong  "#{days_before_beginning} days left"
          text    "to find some place to stay at!"
        end
      end

      def future_trip_message(trip)
        if trip.has_housings?
          few_days_left_message(trip.days_before_beginning)
        else
          create_a_housing_message
        end
      end

      def ongoing_trip_message
        html.p(class: 'trip-status') do
          text    'Time to'
          strong  "enjoy"
          text    "this trip!"
        end
      end
    end
  end
end

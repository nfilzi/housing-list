module Web::Trips
  module Housings
    module Authorizations
      class Create
        private
        attr_reader :trip, :user

        public

        def initialize(user, trip)
          @user = user
          @trip = trip
        end

        def granted?
          trip && future_trip? && user_signed_in? && user_organizer?
        end

        private

        def future_trip?
          trip.starting_on >= Date.today
        end

        def user_organizer?
          TripOrganizerRepository.new.organizes_trip?(user.id, trip.id)
        end

        def user_signed_in?
          !!user
        end
      end
    end
  end
end

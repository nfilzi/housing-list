module Web
  module Trips
    module Authorizations
      class Invite
        private
        attr_reader :trip, :user

        public

        def initialize(user, trip)
          @user = user
          @trip = trip
        end

        def granted?
          future_trip? && user_organizer?
        end

        private

        def future_trip?
          trip.starting_on >= Date.today
        end

        def user_organizer?
          TripOrganizerRepository.new.organizes_trip?(user.id, trip.id)
        end
      end
    end
  end
end

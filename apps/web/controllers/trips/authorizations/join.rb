module Web
  module Trips
    module Authorizations
      class Join
        private
        attr_reader :trip, :user

        public

        def initialize(user, trip)
          @user = user
          @trip = trip
        end

        def granted?
          visitor? || (user && user_not_organizer?)
        end

        private

        def user_not_organizer?
          TripOrganizerRepository.new.organizes_trip?(user.id, trip.id) == false
        end

        def visitor?
          !user
        end
      end
    end
  end
end

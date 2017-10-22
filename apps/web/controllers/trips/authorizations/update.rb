module Web
  module Trips
    module Authorizations
      class Update
        private
        attr_reader :trip, :user

        public

        def initialize(user, trip)
          @user = user
          @trip = trip
        end

        def granted?
          user_organizer?
        end

        private

        def user_organizer?
          TripOrganizerRepository.new.organizes_trip?(user.id, trip.id)
        end
      end
    end
  end
end

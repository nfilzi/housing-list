module Web::Trips
  module Authorizations
    module Base
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

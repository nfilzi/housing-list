module Web
  module Trips
    module Authorizations
      class Show
        private
        attr_reader :token, :trip, :user

        public

        def initialize(user, trip, token=nil)
          @user  = user
          @token = token
          @trip  = trip
        end

        def granted?
          (user_signed_in? && user_organizer?) || visitor_authorized?
        end

        private

        def user_organizer?
          TripOrganizerRepository.new.organizes_trip?(user.id, trip.id)
        end

        def user_signed_in?
          !!user
        end

        def visitor_authorized?
          !token.to_s.empty? && token == trip.invitation_token
        end
      end
    end
  end
end

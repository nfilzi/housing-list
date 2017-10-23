module Web::Trips
  module Authorizations
    class Update
      include Base

      private
      attr_reader :trip, :user

      public

      def initialize(user, trip)
        @user = user
        @trip = trip
      end

      def granted?
        future_trip? && user_signed_in? && user_organizer?
      end
    end
  end
end

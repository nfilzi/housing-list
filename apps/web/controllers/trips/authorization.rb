module Web
  module Trips
    class Authorization
      private
      attr_reader :trip, :user

      public

      def initialize(user, trip=nil)
        @user = user
        @trip = trip
      end

      def show?(token=nil)
        Web::Trips::Authorizations::Show.new(user, trip, token).granted?
      end

      def edit?
        Web::Trips::Authorizations::Update.new(user, trip).granted?
      end

      def invite?
        Web::Trips::Authorizations::Invite.new(user, trip).granted?
      end

      def housing_creation?
        Web::Trips::Housings::Authorizations::Create.new(user, trip).granted?
      end
    end
  end
end

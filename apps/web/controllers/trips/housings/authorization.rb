module Web::Trips
  module Housings
    class Authorization
      private
      attr_reader :housing, :trip, :user

      public

      def initialize(user, trip, housing=nil)
        @user    = user
        @trip    = trip
        @housing = housing
      end

      def create?
        Web::Trips::Housings::Authorizations::Create.new(user, trip).granted?
      end

      def edit?
        Web::Trips::Housings::Authorizations::Update.new(user, trip, housing).granted?
      end

      def dismiss?
        Web::Trips::Housings::Authorizations::Dismiss.new(user, trip, housing).granted?
      end
    end
  end
end

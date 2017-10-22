module Web::Trips
  module Housings
    class Authorization
      private
      attr_reader :user

      public

      def initialize(user)
        @user = user
      end

      def create?(trip)
        Web::Trips::Housings::Authorizations::Create.new(user, @trip).granted?
      end
    end
  end
end

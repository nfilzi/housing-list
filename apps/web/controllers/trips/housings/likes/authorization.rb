module Web::Trips
  module Housings
    module Likes
      class Authorization
        private
        attr_reader :user, :housing, :trip

        public

        def initialize(user, trip, housing=nil)
          @user    = user
          @trip    = trip
          @housing = housing
        end

        def create?
          Web::Trips::Housings::Likes::Authorizations::Create.new(user, trip, housing).granted?
        end

        def destroy?
          Web::Trips::Housings::Likes::Authorizations::Destroy.new(user, trip, housing).granted?
        end
      end
    end
  end
end

require_relative 'authorization'

module Web::Controllers::Trips
  module Housings
    class New
      include Web::Action
      include Web::Trips::Housings::Authorization

      before :load_trip_and_authorize

      expose :trip

      def call(params)
      end
    end
  end
end

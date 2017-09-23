module Web::Controllers::Users
  module Session
    class New
      include Web::Action
      include Web::Users::SkipAuthentication

      def call(params)
      end
    end
  end
end

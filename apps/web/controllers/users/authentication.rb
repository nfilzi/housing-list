module Web
  module Users
    module Authentication
      def self.included(action)
        action.class_eval do
          before :authenticate_user!

          expose :current_user
          expose :user_signed_in?
        end
      end

      private

      def authenticate_user!
        unless user_signed_in?
          store_current_location
          redirect_to(routes.user_sign_in_path)
        end
      end

      def current_user
        @current_user ||= UserRepository.new.find(session[:user_id]) if session[:user_id]
      end

      def store_current_location
        return unless params.env['REQUEST_METHOD'] == 'GET'
        session[:user_return_to] = params.env['REQUEST_PATH']
      end

      def user_signed_in?
        !!current_user
      end
    end
  end
end

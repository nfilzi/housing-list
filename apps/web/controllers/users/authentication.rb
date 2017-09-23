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
          session[:user_return_to] = params.env['REQUEST_PATH']
          redirect_to(routes.user_sign_in_path)
        end
      end

      def user_signed_in?
        !!current_user
      end

      def current_user
        @current_user ||= UserRepository.new.find(session[:user_id]) if session[:user_id]
      end
    end
  end
end

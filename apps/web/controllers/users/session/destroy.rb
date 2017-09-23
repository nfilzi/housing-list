module Web::Controllers::Users
  module Session
    class Destroy
      include Web::Action

      def call(params)
        session[:user_id] = nil
        redirect_to routes.root_path
      end
    end
  end
end

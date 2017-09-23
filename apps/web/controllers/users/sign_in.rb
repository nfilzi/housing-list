module Web
  module Users
    module SignIn

      private

      def create_password(password)
        BCrypt::Password.create(password)
      end

      def password_from_hash(encrypted_password)
        BCrypt::Password.new(encrypted_password)
      end

      def password_matching?(user)
        if user
          return password_from_hash(user.encrypted_password) == params.get(:user, :password)
        else
          create_password('anything') # just to take some time
          return false
        end
      end

      def sign_in_and_redirect(user)
        user_return_to           = session[:user_return_to] || routes.root_path
        session[:user_id]        = user.id
        session[:user_return_to] = nil

        return redirect_to user_return_to
      end
    end
  end
end

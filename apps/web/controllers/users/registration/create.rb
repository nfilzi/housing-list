require_relative '../sign_in'

module Web::Controllers::Users
  module Registration
    class Create
      include Web::Action
      include Web::Users::SkipAuthentication
      include Web::Users::SignIn

      params do
        required(:user).schema do
          required(:email).filled(:str?, format?: /\A[^@\s]+@[^@\s]+\.[^@\s]+\z/)
          required(:password).filled(:str?, min_size?: 6)
        end
      end

      def call(params)
        if params.valid?
          user = UserRepository.new.create(user_params)
          return sign_in_and_redirect(user)
        else
          self.status = 422
        end

      rescue Hanami::Model::UniqueConstraintViolationError
        flash[:alert] = "Email already taken"
        self.status = 422
      end

      private

      def user_params
        encrypted_password = create_password(params.get(:user, :password))

        {
          email:              params.get(:user, :email),
          encrypted_password: encrypted_password
        }
      end
    end
  end
end

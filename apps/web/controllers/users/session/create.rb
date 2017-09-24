require_relative '../sign_in'

module Web::Controllers::Users
  module Session
    class Create
      include Web::Action
      include Web::Users::SkipAuthentication
      include Web::Users::SignIn

      params do
        required(:user).schema do
          required(:email).filled(:str?)
          required(:password).filled(:str?)
        end
      end

      def call(params)
        if params.valid?
          user = UserRepository.new.find_by_email(params.get(:user, :email))

          if password_matching?(user)
            return sign_in_and_redirect(user)
          end
        end

        flash[:alert] = 'Incorect email and/or password'
        self.status = 422
      end
    end
  end
end

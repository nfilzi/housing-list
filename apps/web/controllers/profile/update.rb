module Web::Controllers::Profile
  class Update
    include Web::Action

    expose :profile

    params do
      required(:profile).schema do
        required(:first_name).filled(:str?)
        required(:last_name).filled(:str?)
        required(:email).filled(:str?, format?: /\A[^@\s]+@[^@\s]+\.[^@\s]+\z/)
      end
    end

    def call(params)
      @profile = current_user

      if params.valid?
        UserRepository.new.update(current_user.id, params[:profile])

        redirect_to routes.edit_profile_path
      else
        self.status = 422
      end
    end
  end
end

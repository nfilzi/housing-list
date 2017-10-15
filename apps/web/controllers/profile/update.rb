module Web::Controllers::Profile
  class Update
    include Web::Action

    expose :profile

    params do
      required(:profile).schema do
        required(:first_name).filled(:str?)
        required(:last_name).filled(:str?)
        required(:email).filled(:str?, format?: /\A[^@\s]+@[^@\s]+\.[^@\s]+\z/)
        required(:avatar_picture).maybe
      end
    end

    def call(params)
      @profile = current_user
      result = Profile::Update.new(@profile, params).call

      if result.successful?
        redirect_to routes.edit_profile_path
      else
        self.status = 422
      end
      # UserRepository.new.update(current_user.id, params[:profile])
    end
  end
end

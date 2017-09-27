module Web::Controllers::Profile
  class Edit
    include Web::Action

    expose :profile

    def call(params)
      @profile = current_user
    end
  end
end

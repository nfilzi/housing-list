module Web::Views::Profile
  class Update
    include Web::View
    template 'profile/edit'

    def profile
      UserPresenter.new(locals[:profile])
    end

    def sticky_navbar
      true
    end

    def after_js
      javascript('display-background-picture-preview', async: true)
    end
  end
end

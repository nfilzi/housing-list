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
      javascript('picture-upload-preview', async: true)
    end
  end
end

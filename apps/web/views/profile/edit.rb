module Web::Views::Profile
  class Edit
    include Web::View

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

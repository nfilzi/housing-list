module Web::Views::Profile
  class Edit
    include Web::View

    def profile
      UserPresenter.new(locals[:profile])
    end

    def sticky_navbar
      true
    end
  end
end

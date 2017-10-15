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
  end
end

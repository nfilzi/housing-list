module Web::Views::Profile
  class Update
    include Web::View
    template 'profile/edit'

    def sticky_navbar
      true
    end
  end
end

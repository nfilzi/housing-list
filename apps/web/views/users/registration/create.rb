module Web::Views::Users
  module Registration
    class Create
      include Web::View
      template 'users/registration/new'

      def sticky_navbar
        true
      end
    end
  end
end

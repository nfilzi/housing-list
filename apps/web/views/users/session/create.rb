module Web::Views::Users
  module Session
    class Create
      include Web::View
      template 'users/session/new'

      def sticky_navbar
        true
      end
    end
  end
end

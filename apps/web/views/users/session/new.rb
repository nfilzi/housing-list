module Web::Views::Users
  module Session
    class New
      include Web::View

      def sticky_navbar
        true
      end
    end
  end
end

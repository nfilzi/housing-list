module Web::Views::Static
  module Home
    class Show
      include Web::View

      layout false

      def sticky_navbar
        false
      end
    end
  end
end

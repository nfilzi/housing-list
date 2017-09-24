module Web
  module Views
    class ApplicationLayout
      include Web::Layout

      root configuration.root.join('layouts')

      def sticky_navbar
        false
      end
    end
  end
end

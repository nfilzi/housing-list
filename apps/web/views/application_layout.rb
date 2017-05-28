module Web
  module Views
    class ApplicationLayout
      include Web::Layout

      root configuration.root.join('layouts')
    end
  end
end

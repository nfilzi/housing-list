module Web::Views::Home
  class Show
    include Web::View

    layout false

    def sticky_navbar
      false
    end
  end
end

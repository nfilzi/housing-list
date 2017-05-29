module Web::Views::Styleguide
  class Show
    include Web::View
    include Web::Helpers::DateFormatter

    def base_font
       'Roboto Mono'
    end

    def header_font
      'Rubik'
    end
  end
end

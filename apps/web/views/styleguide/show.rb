module Web::Views::Styleguide
  class Show
    include Web::View
    include Web::Helpers::DateFormatter
    include Web::Helpers::TextFormatter
    include Web::Helpers::Housings
  end
end

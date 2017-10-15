module Web::Views::Styleguide
  class Show
    include Web::View
    include Web::Helpers::DateFormatter
    include Web::Helpers::TextFormatter

    def housing
      HousingPresenter.new(locals[:housing])
    end
  end
end

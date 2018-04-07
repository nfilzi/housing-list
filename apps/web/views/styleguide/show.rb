module Web::Views::Styleguide
  class Show
    include Web::View
    include Web::Helpers::DateFormatter
    include Web::Helpers::TextFormatter

    # Housing component

    def housing
      HousingPresenter.new(locals[:housing])
    end

    def housing_pending
      HousingPresenter.new(locals[:housing_pending])
    end

    def housing_authorization(housing)
      Web::Trips::Housings::Authorization.new(current_user, trip, housing)
    end
  end
end

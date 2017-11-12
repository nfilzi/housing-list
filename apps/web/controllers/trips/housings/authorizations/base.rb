module Web::Trips::Housings::Authorizations
  module Base
    def housing_active?
      !housing.dismissed
    end
  end
end

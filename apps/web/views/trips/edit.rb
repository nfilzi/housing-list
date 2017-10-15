module Web::Views::Trips
  class Edit
    include Web::View

    def trip
      TripPresenter.new(locals[:trip])
    end

    def after_js
      javascript('display-background-picture-preview', async: true)
    end
  end
end

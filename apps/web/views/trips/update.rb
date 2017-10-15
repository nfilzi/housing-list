module Web::Views::Trips
  class Update
    include Web::View
    template 'trips/edit'

    def trip
      TripPresenter.new(locals[:trip])
    end

    def after_js
      javascript('display-background-picture-preview', async: true)
    end
  end
end

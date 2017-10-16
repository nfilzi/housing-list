module Web::Views::Trips
  class Update
    include Web::View
    template 'trips/edit'

    def trip
      TripPresenter.new(locals[:trip])
    end

    def after_js
      javascript('picture-upload-preview', async: true)
    end
  end
end

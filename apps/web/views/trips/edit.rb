module Web::Views::Trips
  class Edit
    include Web::View

    def trip
      TripPresenter.new(locals[:trip])
    end

    def after_js
      javascript('picture-upload-preview', async: true)
    end
  end
end

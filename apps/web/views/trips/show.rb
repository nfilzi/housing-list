module Web::Views::Trips
  class Show
    include Web::View
    include Web::Helpers::DateFormatter
    include Web::Helpers::TextFormatter

    def housings
      locals[:housings].map { |housing| HousingPresenter.new(housing) }
    end

    def trip
      TripPresenter.new(locals[:trip])
    end

    def after_js
      javascript('copy-invitation-link', async: true)
    end

    # Meta tags

    def meta_tag_title
      "We are going to #{trip.destination}!"
    end

    def meta_tag_description
      "#{trip.travelers_count} people are a part of this trip, from #{trip.date(trip.starting_on)} to #{trip.date(trip.ending_on)}. Time to get organized."
    end

    def meta_tag_image
      return asset_url('lake-geneva.jpg') unless trip.picture_uuid

      trip.background_picture_url(version: :meta)
    end
  end
end

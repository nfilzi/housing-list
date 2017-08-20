module Web::Controllers::Trips
  class Create
    include Web::Action

    params do
      required(:trip).schema do
        required(:destination).filled(:str?)
        required(:starting_on).filled(:date?)
        required(:ending_on).filled(:date?)
        required(:travelers_count).filled(:int?)
      end
    end

    def call(params)
      if params.valid?
        trip = TripRepository.new.create(params[:trip])

        redirect_to routes.trip_path(trip.id)
      else
        self.status = 422
      end
    end
  end
end

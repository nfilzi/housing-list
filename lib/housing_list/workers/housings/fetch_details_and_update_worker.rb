module Housings
  class FetchDetailsAndUpdateWorker
    include Sidekiq::Worker

    def perform(housing_id)
      housing = HousingRepository.new.find_with_trip(housing_id)
      FetchDetailsAndUpdate.new(housing).call
    end
  end
end

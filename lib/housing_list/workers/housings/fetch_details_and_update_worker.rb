module Housings
  class FetchDetailsAndUpdateWorker
    include Sidekiq::Worker

    def perform(housing_id)
      housing = HousingRepository.new.find(housing_id)
      FetchDetailsAndUpdate.new(housing).call
    end
  end
end

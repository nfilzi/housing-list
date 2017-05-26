class HousingRepository < Hanami::Repository
  associations do
    belongs_to :trip
    belongs_to :user
  end
end

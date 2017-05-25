class UserRepository < Hanami::Repository
  associations do
    has_many :housings
  end
end

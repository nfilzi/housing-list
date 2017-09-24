class UserRepository < Hanami::Repository
  associations do
    has_many :housings
  end

  def find_by_email(email)
    users.where(email: email).first
  end
end

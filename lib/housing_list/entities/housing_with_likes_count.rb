require_relative 'user'

class HousingWithLikesCount < Hanami::Entity
  attr_reader :likes_count

  def initialize(attributes={})
    @likes_count      = attributes[:likes_count] || 0
    attributes[:user] = build_user(attributes)

    super(attributes)
  end

  private

  def build_user(attributes)
    user_attribute_names = attributes.keys.select { |key| key.match /^users_.*$/ }

    user_attributes = user_attribute_names.reduce({}) do |user_attributes, original_name|
      name  = original_name.to_s.gsub('users_', '').to_sym
      value = attributes[original_name]

      attributes.delete(original_name)

      user_attributes[name] = value
      user_attributes
    end

    return User.new(user_attributes)
  end
end

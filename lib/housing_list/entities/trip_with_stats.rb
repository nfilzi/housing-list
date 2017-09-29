class TripWithStats < Trip
  attr_reader :housings_count, :total_price_avg

  def initialize(attributes={})
    @housings_count  = attributes[:housings_count]
    @total_price_avg = attributes[:total_price_avg].to_i

    # must be the last operation because the entity is frozen at initialize
    super
  end
end

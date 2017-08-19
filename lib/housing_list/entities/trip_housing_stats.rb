class TripHousingStats
  attr_reader :housings_count, :total_price_min, :total_price_max, :trip_id

  def initialize(trip_id:, housings_count: 0, total_price_avg: 0, total_price_min: 0, total_price_max: 0)
    @trip_id         = trip_id
    @housings_count  = housings_count
    @total_price_avg = total_price_avg
    @total_price_min = total_price_min
    @total_price_max = total_price_max
  end

  def total_price_avg
    @total_price_avg.to_i
  end
end

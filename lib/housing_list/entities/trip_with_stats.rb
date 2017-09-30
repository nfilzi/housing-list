class TripWithStats < Hanami::Entity
  attr_reader :housings_count,
              :total_price_avg,
              :total_price_avg_per_pers,
              :total_price_min,
              :total_price_min_per_pers,
              :total_price_max,
              :total_price_max_per_pers

  def initialize(attributes={})
    travelers_count = attributes[:travelers_count]

    @housings_count  = attributes[:housings_count]
    @total_price_avg = (attributes[:total_price_avg] || 0).to_i
    @total_price_min = attributes[:total_price_min] || 0
    @total_price_max = attributes[:total_price_max] || 0

    @total_price_avg_per_pers = (@total_price_avg / travelers_count).to_i
    @total_price_min_per_pers = (@total_price_min / travelers_count)
    @total_price_max_per_pers = (@total_price_max / travelers_count)

    super
  end
end

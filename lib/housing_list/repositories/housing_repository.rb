class HousingRepository < Hanami::Repository
  associations do
    belongs_to :trip
    belongs_to :user
  end

  def find_with_user(id)
    wrap_user.by_pk(id).as(Housing).one
  end

  def for_trip_sorted_by_most_recent(trip_id)
    wrap_user.where(trip_id: trip_id).order(Sequel.desc(:created_at)).as(Housing).to_a
  end

  def stats_for_trip(trip_id)
    relations[:housings].select {
        [
          :trip_id,
          int::count(id).as(:housings_count),
          int::avg(total_price).as(:total_price_avg),
          int::min(total_price).as(:total_price_min),
          int::max(total_price).as(:total_price_max)
        ]
      }.
      where(trip_id: trip_id).
      group(:trip_id).
      order(:trip_id). # provided by Hanami/ROM by default :/
      as(TripHousingStats).
      one
  end

  private

  def wrap_user
    relations[:housings].wrap(:user)
  end
end

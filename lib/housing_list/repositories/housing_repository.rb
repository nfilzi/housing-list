class HousingRepository < Hanami::Repository
  associations do
    belongs_to :trip
    belongs_to :user

    has_many   :likes
  end

  def find_for_trip(id, trip_id)
    housings.where(trip_id: trip_id, id: id).one
  end

  def find_with_user(id)
    wrap_user.by_pk(id).as(Housing).one
  end

  def active_for_trip_sorted_by_most_liked_and_recent(trip_id)
    for_trip_sorted_by_most_liked_and_recent(trip_id).where(dismissed: false).
      to_a.lazy.map { |attributes| HousingWithLikesCount.new(attributes) }
  end

  def dismissed_for_trip_sorted_by_most_liked_and_recent(trip_id)
    for_trip_sorted_by_most_liked_and_recent(trip_id).where(dismissed: true).
      to_a.lazy.map { |attributes| HousingWithLikesCount.new(attributes) }
  end

  private

  def for_trip_sorted_by_most_liked_and_recent(trip_id)
    likes_stats = relations[:likes].select {
        [
          :housing_id,
          int::count(Sequel.qualify(:likes, :housing_id)).as(:likes_count),
        ]
      }.
      group(:housing_id).
      order(:housing_id)

    wrap_user.
      dataset.
      select_append(:likes_count).
      join_table(:left, likes_stats.dataset, housing_id: Sequel.qualify(:housings, :id)).
      where(trip_id: trip_id).
      order(
        Sequel.desc(:likes_count, nulls: :last),
        Sequel.desc(Sequel.qualify(:housings, :created_at))
      )
  end

  def wrap_user
    relations[:housings].wrap(:user)
  end
end

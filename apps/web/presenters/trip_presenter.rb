class TripPresenter
  include Hanami::Presenter
  include Web::Helpers::DateFormatter

  def days_before_beginning
    (starting_on - Date.today).to_i
  end

  def date(date)
    format_date(date, format: '%b %e %Y', ordinal_indicator: true)
  end

  def has_housings?
    housings_count >= 1
  end

  def future?
    Date.today < starting_on
  end

  def ongoing?
    Date.today >= starting_on && Date.today <= ending_on
  end

  def completed?
    Date.today > ending_on
  end
end

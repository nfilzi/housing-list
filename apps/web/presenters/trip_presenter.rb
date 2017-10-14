class TripPresenter
  include Hanami::Presenter
  include Hanami::Helpers::EscapeHelper
  include Web::Helpers::DateFormatter

  def duration
    (ending_on - starting_on).to_i
  end

  def days_before_beginning
    (starting_on - Date.today).to_i
  end

  def date(date)
    format_date(date, format: '%b %e %Y', ordinal_indicator: true)
  end

  def has_housings?
    housings_count >= 1
  end

  # statuses

  def future?
    Date.today < starting_on
  end

  def ongoing?
    Date.today >= starting_on && Date.today <= ending_on
  end

  def completed?
    Date.today > ending_on
  end

  def status
    case
    when future?
      :future
    when ongoing?
      :ongoing
    when completed?
      :completed
    end
  end

  def status_message
    message = case status
      when :future
        if has_housings?
          "Only <strong>#{days_before_beginning} days left</strong> to find some place to stay at!"
        else
          "<span class='icon'>👆</span> Let's create <strong>your first housing!</strong>"
        end
      when :ongoing
        "Time to <strong>enjoy</strong> this trip!"
      when :completed
        "Hope you <strong>enjoyed</strong> this trip!"
      end

    raw message
  end
end

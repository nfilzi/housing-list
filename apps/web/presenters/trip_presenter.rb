class TripPresenter
  include Hanami::Presenter
  include Hanami::Helpers::EscapeHelper
  include Web::Assets::Helpers
  include Web::Helpers::DateFormatter
  include Web::Helpers::UploadcareFile

  def background_picture_url(version:)
    size_operations = {
      thumbnail: 'resize/400x',
      banner: 'preview',
      meta: 'crop/1200x630/center'
    }

    return uploadcare_url(
      picture_uuid,
      default: 'lake-geneva.jpg',
      size_operation: size_operations[version]
    )
  end

  def days_before_beginning
    (starting_on - Date.today).to_i
  end

  def date(date)
    format_date(date, format: '%b %e %Y', ordinal_indicator: true)
  end

  def duration
    (ending_on - starting_on).to_i
  end

  def has_housings?
    housings_count >= 1
  end

  def search_url(provider:)
    unless Housing::SUPPORTED_PROVIDERS.include?(provider)
      raise ArgumentError, "#{provider} is not supported as a provider yet!"
    end

    parameters = to_h.slice(:destination, :travelers_count, :starting_on, :ending_on)
    Providers::SearchURL.generate(provider, parameters)
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
          "<span class='icon'>👆</span> Let's add <strong>your first housing!</strong>"
        end
      when :ongoing
        "Time to <strong>enjoy</strong> this trip!"
      when :completed
        "Hope you <strong>enjoyed</strong> this trip!"
      end

    raw message
  end
end

class UserPresenter
  include Hanami::Presenter
  include Web::Assets::Helpers

  def avatar_url(version:)
    return asset_path('avatar.jpg') unless avatar_uuid

    size_operations = {
      default:  "resize/50x/-/crop/50x50/center",
      large:    "resize/110x/-/crop/110x110/center"
    }

    operations = [
      size_operations[version],
      "quality/lighter",
      "progressive/yes",
      "autorotate/yes",
    ]

    return "https://ucarecdn.com/#{avatar_uuid}/-/#{operations.join("/-/")}/"
  end
end

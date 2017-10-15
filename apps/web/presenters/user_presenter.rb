class UserPresenter
  include Hanami::Presenter
  include Web::Assets::Helpers

  def avatar_url(version: :default)
    return asset_path('avatar.jpg') unless avatar_uuid

    size_operations = {
      default:  "scale_crop/300x300/center"
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

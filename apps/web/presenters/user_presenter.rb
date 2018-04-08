class UserPresenter
  include Hanami::Presenter
  include Web::Assets::Helpers
  include Web::Helpers::UploadcareFile

  def avatar_url(version: :default)
    size_operations = {
      default:   'scale_crop/300x300/center',
      thumbnail: 'scale_crop/100x100/center'
    }

    return uploadcare_url(
      avatar_uuid,
      default: 'avatar.jpg',
      size_operation: size_operations[version]
    )
  end
end

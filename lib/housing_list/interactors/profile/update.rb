require 'hanami/interactor'

module Profile
  class Update
    include Hanami::Interactor

    expose :profile

    private
    attr_reader :profile, :params

    public

    def initialize(profile, params)
      @profile = profile
      @params  = params
    end

    def call
      avatar_uuid = upload_new_avatar_and_delete_old_one
      @profile    = UserRepository.new.update(profile.id, profile_params(avatar_uuid))
    end

    private

    def profile_params(avatar_uuid)
      params[:profile].merge(avatar_uuid: avatar_uuid)
    end

    def upload_new_avatar_and_delete_old_one
      return profile.avatar_uuid unless params[:profile][:avatar_picture]

      # TODO: enqueue async job instead
      FileRemover.call(profile.avatar_uuid) if profile.avatar_uuid

      filepath = params[:profile][:avatar_picture][:tempfile]
      uc_file  = FileUploader.call(filepath)

      return uc_file.uuid
    end

    def valid?
      params.valid?
    end
  end
end

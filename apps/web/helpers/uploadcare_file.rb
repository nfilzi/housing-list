module Web
  module Helpers
    module UploadcareFile
      def uploadcare_url(file_uuid, size_operation:, default:)
        return asset_path(default) unless file_uuid

        operations = [
          'quality/lighter',
          'progressive/yes',
          'autorotate/yes',
        ]

        operations << size_operation

        return "https://ucarecdn.com/#{file_uuid}/-/#{operations.join("/-/")}/"
      end
    end
  end
end

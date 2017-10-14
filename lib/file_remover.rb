require 'uploadcare'

class FileRemover
  private
  attr_reader :api_client

  public

  def self.call(filepath)
    new.call(filepath)
  end

  def initialize
    setup_uploadcare_api_client
  end

  def call(file_uuid)
    api_client.delete_files([file_uuid])
  end

  private

  def setup_uploadcare_api_client
    settings = {
      public_key:   ENV.fetch('UPLOADCARE_PUBLIC_KEY'),
      private_key:  ENV.fetch('UPLOADCARE_PRIVATE_KEY')
    }

    @api_client = Uploadcare::Api.new(settings)
  end
end

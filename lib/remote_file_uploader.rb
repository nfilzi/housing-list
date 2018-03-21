require 'uploadcare'

class RemoteFileUploader
  private
  attr_reader :api_client

  public

  def self.call(file_url)
    new.call(file_url)
  end

  def initialize
    setup_uploadcare_api_client
  end

  def call(file_url)
    api_client.upload_from_url(file_url)
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

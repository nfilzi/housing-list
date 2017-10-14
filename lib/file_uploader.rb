require 'uploadcare'

class FileUploader
  private
  attr_reader :api_client

  public

  def self.call(filepath)
    new.call(filepath)
  end

  def initialize
    setup_uploadcare_api_client
  end

  def call(filepath)
    file = File.open(filepath)
    api_client.upload(file)
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

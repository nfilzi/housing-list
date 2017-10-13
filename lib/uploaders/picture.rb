require "uploadcare"
module Uploaders
  class Picture
    private
    attr_reader :filepath, :api_client

    public
    def initialize(filepath)
      @filepath = filepath
    end

    def call
      setup_uploadcare_api_client
      file = File.open(filepath)
      api_client.upload(file)
    end

    private
    def setup_uploadcare_api_client
      settings = {
        public_key:   ENV.fetch("UPLOADCARE_PUBLIC_KEY"),
        private_key:  ENV.fetch("UPLOADCARE_PRIVATE_KEY")
      }
      @api_client = Uploadcare::Api.new(settings)
    end
  end
end

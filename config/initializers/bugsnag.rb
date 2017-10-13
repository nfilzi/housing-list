Bugsnag.configure do |config|
  config.api_key       = ENV.fetch('BUGSNAG_API_KEY')
  config.logger        = Hanami.logger
  config.project_root  = Hanami.root
  config.release_stage = Hanami.env
end

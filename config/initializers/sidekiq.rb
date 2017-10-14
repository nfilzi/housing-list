require 'sidekiq/web'

Sidekiq.configure_server do |config|
  config.redis = { url: ENV.fetch('REDIS_URL'), size: 7 }
end

Sidekiq.configure_client do |config|
  config.redis = { url: ENV.fetch('REDIS_URL'), size: 3 }
end

Sidekiq::Web.session_secret = ENV['WEB_SESSIONS_SECRET']

Sidekiq::Web.use(Rack::Auth::Basic) do |user, password|
  [user, password] == [ENV.fetch('SIDEKIQ_USERNAME'), ENV.fetch('SIDEKIQ_PASSWORD')]
end

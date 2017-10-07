Sidekiq.configure_server do |config|
  config.redis = { url: ENV.fetch('REDIS_URL'), size: 7 }
end

Sidekiq.configure_client do |config|
  config.redis = { url: ENV.fetch('REDIS_URL'), size: 3 }
end

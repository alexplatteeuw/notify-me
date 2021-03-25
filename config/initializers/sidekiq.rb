Sidekiq.configure_client do |config|
  config.redis = { url: ENV.fetch('HEROKU_REDIS_TEAL_URL') { "redis://localhost:6379/1" }, size: 1, network_timeout: 5 }
end

Sidekiq.configure_server do |config|
  config.redis = { url: ENV.fetch('HEROKU_REDIS_TEAL_URL') { "redis://localhost:6379/1" }, size: 12, network_timeout: 5 }
end

Sidekiq::Extensions.enable_delay!

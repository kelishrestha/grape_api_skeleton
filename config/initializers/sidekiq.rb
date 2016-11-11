require 'resolv-replace'
require 'sidekiq/web'

path = File.expand_path('../../redis.yml', __FILE__)
redis_config = YAML.load(ERB.new(File.read(path)).result)[(ENV['RACK_ENV'] || 'development')]
sidekiq_db = redis_config['db'] || 0
redis_port = redis_config['port']
redis_host = redis_config['host']

Sidekiq.configure_server do |config|
  config.redis = {
    url: "redis://#{redis_host}:#{redis_port}/#{redis_config['db']}",
    namespace: 'sidekiq'
  }
end

Sidekiq.configure_client do |config|
  config.redis = {
    url: "redis://#{redis_config['sidekiq_host'] || redis_host}:#{redis_port}/#{sidekiq_db}",
    namespace: 'sidekiq', size: 1
  }
end

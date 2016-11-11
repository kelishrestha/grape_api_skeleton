Bundler.require
require File.join(File.dirname(__FILE__), 'app.rb')
use Rack::CommonLogger, AppLogger.logger_instance

require 'sidekiq/web'
if ENV['RACK_ENV'] == 'production'
  Sidekiq::Web.use Rack::Auth::Basic do |u, p|
    u == 'skeleton' && Digest::SHA1.hexdigest(p) == '1cdcb22960063494f152f5ddf0a25d5234c21d5c'
  end
end

run Rack::URLMap.new('/' => Skeleton::App, '/sidekiq' => Sidekiq::Web)

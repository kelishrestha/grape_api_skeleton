honeybadger_config = Honeybadger::Config.new(
  env: (ENV['RACK_ENV'] || 'development')
)

Honeybadger.start(honeybadger_config)
# use Honeybadger::Rack::ErrorNotifier, honeybadger_config
# use Honeybadger::Rack::MetricsReporter, honeybadger_config

module ErrorNotifier
  def notify_error_tracker(e, params = {}, reraise_exception = true)
    logger.info(params.to_json)
    honeybadger_error_tracker(e, params, reraise_exception)
  end

  def honeybadger_error_tracker(e, params = {}, reraise_exception = true)
    ::Honeybadger.notify(e, parameters: params)
    # reraise the exception for development environment
    raise e if reraise_exception && ENV['RACK_ENV'] == 'development'
  end
end

Object.class_eval do
  include ErrorNotifier
  extend ErrorNotifier
end

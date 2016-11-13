honeybadger_config = Honeybadger::Config.new(
  env: (ENV['RACK_ENV'] || 'development')
)

Honeybadger.start(honeybadger_config)
# use Honeybadger::Rack::ErrorNotifier, honeybadger_config
# use Honeybadger::Rack::MetricsReporter, honeybadger_config

# Error Notifying Mechanism
module ErrorNotifier
  def notify_error_tracker(excp, params = {})
    data = params.except!(:reraise_exception)
    reraise_exception = retrieve_exception_info(data)
    logger.info(params.to_json)
    ::Honeybadger.notify(excp, parameters: params)
    # Re-raise exception for development environment
    raise excp if reraise_exception && ENV['RACK_ENV'] == 'development'
  end

  private

  def retrieve_exception_info(data)
    reraise_exception = data[:reraise_exception] || true
  end
end

Object.class_eval do
  include ErrorNotifier
  extend ErrorNotifier
end

require 'logger'
# Logging Mechanism
module AppLogger
  class << self
    def logger_instance
      @logger_instance ||= Logger.new(log_file).tap do |logger|
        ::Logger.class_eval { alias_method :write, :'<<' }
        logger_setting(logger)
      end
    end

    def logger_setting(logger)
      logger.level = ::Logger::DEBUG
      logger.formatter = proc do |_severity, datetime, _progname, msg|
        formatted_log_message(msg, datetime)
      end
    end

    def log_file
      rack_env = ENV['RACK_ENV']
      if rack_env == 'development'
        @log_file ||= STDOUT
      else
        file_path = File.join('log', "#{rack_env}.log")
        @log_file ||= File.new(file_path, 'a+').tap do |file|
          file.sync = true
        end
      end
    end

    private

    def formatted_log_message(message, datetime)
      message = parsed_message(message)
      msg = message.is_a?(Hash) ? message : { message: message }
      msg_hash = {}
      msg.each do |key, value|
        msg_hash[key.to_s] = parsed_message(value)
      end
      timestamp = datetime.strftime('%Y-%m-%dT%H:%M:%SZ')
      log = { '@timestamp' => timestamp.to_s }.merge(msg).to_json
      "#{log}\n"
    end

    def parsed_message(message)
      JSON.parse(message)
    rescue StandardError
      message
    end
  end
end

def logger
  AppLogger.logger_instance
end

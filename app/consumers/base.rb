# frozen_string_literal: true
require './app.rb'
module Consumer
  # Base Consumer
  module Base
    private

    def execute(message)
      params = message.fetch(:body, message)
      params = params.with_indifferent_access

      yield(params)
    rescue => excp
      AppLogger.logger_instance.error(exception: excp,
                                      message: message,
                                      caller: caller_locations(1, 1)[0].label)
    end
  end
end

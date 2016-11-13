# frozen_string_literal: true
# require File.join(File.dirname(__FILE__), 'v1', 'base')
module API
  # Base API class to mount multiple versions base classes
  class Base < Grape::API
    helpers do
      def logger
        AppLogger.logger
      end

      # log errors after catching exception
      def log_error(excp)
        msg = {
          error_class: excp.class.to_s,
          message: excp.to_s,
          url: env['REQUEST_URI'].to_s,
          method: env['REQUEST_METHOD'].to_s,
          payload: env['rack.request.form_hash'].inspect.to_s
        }
        notify_error(e, msg)
      end

      # Protecting attributes being updated if they haven't been declared
      def permitted_params
        declared(params, include_missing: false)
      end

      def response_message(message, code = 422)
        status code
        { message: message }
      end

      def request_accepted_response(message, location, state = 'processing')
        status 202
        { status: state, message: message, location: location }
      end

      def authenticate
        api_key = request.env['HTTP_X_API_TOKEN'] || ''
        api_key_valid = ApiKey.authorize(api_key)
        return if api_key_valid
        error!({ message: 'Unauthorized. Invalid API token.' }, 401)
      end
    end

    before do
      authenticate
    end

    # mount API::V1::Base
  end
end

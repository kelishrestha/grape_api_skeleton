# encoding: utf-8
# frozen_string_literal: true
require File.expand_path('../boot', __FILE__)

# Application Module
module Skeleton
  #  API class to mount all the Base API endpints
  class App < Grape::API
    rescue_from :all do |exception|
      ErrorNotifier.notify_error_tracker(exception)
      error!({ message: 'Internal server error' }, 500)
    end
    mount API::Base
  end
end

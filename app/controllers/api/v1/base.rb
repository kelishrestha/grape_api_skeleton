# frozen_string_literal: true
module API
  module V1
    # Base API class to mount multiple versions base classes
    class Base < Grape::API
      version 'v1'

      get '/status' do
        'App is up and running'
      end
    end
  end
end

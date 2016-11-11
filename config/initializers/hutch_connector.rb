# Hutch Connector
module Hutch
  module Connector
    extend self

    def establish_connection
      hutch_config = config
      Hutch::Config.initialize.merge!(mq_username: hutch_config['mq_username'],
                                      mq_password: hutch_config['mq_password'],
                                      mq_host: hutch_config['mq_host'],
                                      mq_api_host: hutch_config['mq_host'],
                                      mq_vhost: hutch_config['mq_vhost'],
                                      channel_prefetch: 1,
                                      force_publisher_confirms: true)
    end

    def config
      path = File.expand_path('../../hutch.yml', __FILE__)
      YAML.load(ERB.new(File.read(path)).result)[(ENV['RACK_ENV'] || 'development')]
    end
  end
end

Hutch::Connector.establish_connection

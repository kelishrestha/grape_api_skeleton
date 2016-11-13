module Hutch
  # Hutch Connector
  module Connector
    def self.establish_connection
      hutch_config = config
      rmq_host = hutch_config['mq_host']
      Hutch::Config.initialize.merge!(mq_username: hutch_config['mq_username'],
                                      mq_password: hutch_config['mq_password'],
                                      mq_host: rmq_host,
                                      mq_api_host: rmq_host,
                                      mq_vhost: hutch_config['mq_vhost'],
                                      channel_prefetch: 1,
                                      force_publisher_confirms: true)
    end

    private

    def self.config
      path = File.expand_path('../../hutch.yml', __FILE__)
      YAML.load(ERB.new(File.read(path)).result)[(ENV['RACK_ENV'] || 'development')]
    end
  end
end

Hutch::Connector.establish_connection

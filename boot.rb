require 'rubygems'
require 'bundler'

module App
  def self.root
    @root_path ||= FileUtils.pwd
  end
end

ENV['RACK_ENV'] ||= 'development'
Bundler.require(:default, ENV['RACK_ENV'].to_sym)
I18n.enforce_available_locales = false

Dir["#{App.root}/config/initializers/*.rb"].sort.each { |file| require_relative(file) }
Dir["#{App.root}/lib/**/*.rb"].sort.each { |file| require_relative(file) }

Dir["#{App.root}/app/models/**/*.rb"].sort.each { |file| require_relative(file) }
Dir["#{App.root}/app/controllers/**/*.rb"].sort.each { |file| require_relative(file) }
Dir["#{App.root}/app/consumers/**/*.rb"].sort.each { |file| require_relative(file) }
Dir["#{App.root}/app/sidekiq_workers/**/*.rb"].sort.each { |file| require_relative(file) }

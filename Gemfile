source 'https://rubygems.org'

gem 'grape'
gem 'grape-entity'

gem 'httparty'
gem 'hutch', '=0.21'

gem 'json'

gem 'newrelic_rpm'
gem 'newrelic-redis'

gem 'pg'
# Use activerecord
gem 'activerecord'
gem 'sinatra-activerecord'

gem 'tux'
gem 'honeybadger'

### Async Processing ###
gem 'sidekiq'
gem 'sidekiq-monitor-stats'

gem 'puma'

gem 'redis'

# namespaced subset of your redis keyspace
# sidekiq >= 4.0 has no longer redis namespace as dependency
# however, our redis connection is namespaced
# so we need it for now
gem 'redis-namespace'

group :development do
  gem 'shotgun'
end

group :development, :test do
  gem 'awesome_print'
  gem 'brakeman'
  gem 'colorize'
  gem 'guard', require: false
  gem 'guard-rspec', require: false
  gem 'pry'
  gem 'pry-nav'
  gem 'rubocop', require: false
end

group :test do
  gem 'database_cleaner'
  gem 'factory_girl'
  gem 'faker'
  gem 'rack-test', require: 'rack/test'
  gem 'rspec'
  gem 'shoulda-matchers'
  gem 'simplecov', require: false
  gem 'timecop'
end

group :production do
end

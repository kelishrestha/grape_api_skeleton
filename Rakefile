Bundler.require
require 'sinatra/activerecord/rake'
require './app'

task default: :help

Dir['tasks/*.rake'].each { |task| load task }

task :console do
  puts 'Loading development console...'
  system('irb -r ./app.rb')
end

task :server do
  puts 'Loading development console...'
  system('bundle exec shotgun -p 3003')
end

task :routes do
  Skeleton::App.routes.each do |route|
    puts route.to_s.colorize(:green)
  end
end

desc 'Run specs'
task :spec do
  system('bundle exec rspec')
end

task :rcov do
  ENV['COVERAGE'] = 'true'
  Rake::Task['spec'].execute
end

task :help do
  db_tasks = <<DBTASKS
  ##########################################
                UTILITY TASKS
  ##########################################
  rake console                # Run a IRB console with all enviroment loaded
  rake spec                   # Run specs
  rake rcov                   # Run specs and calculate coverage
  rake server                 # Run shotgun server in 3010 port

  ##########################################
                DATABASE RELATED TASKS
  ##########################################
  rake db:create              # Creates the database from DATABASE_URL
                              # or config/database.yml for the current ENV
  rake db:create_migration    # Create a migration (parameters: NAME, VERSION)
  rake db:drop                # Drops the database from DATABASE_URL
                              # or config/database.yml for the current ENV
  rake db:fixtures:load       # Load fixtures into the current environment's database
  rake db:migrate             # Migrate the database
                              # (options: VERSION=x, VERBOSE=false, SCOPE=blog)
  rake db:migrate:status      # Display status of migrations
  rake db:rollback            # Rolls the schema back to the
                              # previous version (specify steps w/ STEP=n)
  rake db:schema:cache:clear  # Clear a db/schema_cache.dump file
  rake db:schema:cache:dump   # Create a db/schema_cache.dump file
  rake db:schema:dump         # Create a db/schema.rb file that is portable
                              # against any DB supported by AR
  rake db:schema:load         # Load a schema.rb file into the database
  rake db:seed                # Load the seed data from db/seeds.rb
  rake db:setup               # Create the database, load the schema, and
                              # initialize with the seed data (use db:reset to
                              # also drop the database first)
  rake db:structure:dump      # Dump the database structure to db/structure.sql
  rake db:structure:load      # Recreate the databases from the structure.sql file
  rake db:version             # Retrieves the current schema version number
DBTASKS
  puts db_tasks.colorize(:green)
end

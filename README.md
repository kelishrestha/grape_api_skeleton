Grape API Skeleton
========

## Technology

1. Ruby 2.3.1
2. Postgresql (as permanent data store)
4. Grape
5. Shotgun/Puma (as app server in Development)
6. Puma (as app server in Production)
7. RabbitMQ (as messaging system)
8. Sidekiq-Pro (as background job)

## Setup

### Install Dependencies

  For mac

      brew install postgresql
      brew install rabbitmq

  For Debian

      apt-get install postgresql
      apt-get install rabbitmq

  Run

      bundle install

Start Servers
-------------
    rabbitmq-server


Setup Configuration
-------------------

    ./configure


Bring up App Server
-------------------
    bundle exec puma -C config/puma.rb
        or
    bundle exec shotgun

Run test
-------------------
    bundle exec rspec

Ruby StyleGuide check
---------------------
    bundle exec rubocop


Interactive Session via Terminal
--------------------------------

    bundle exec tux

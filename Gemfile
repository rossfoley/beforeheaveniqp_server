source 'https://rubygems.org'
ruby '2.1.2'

# Basic Rails gems
gem 'rails', '4.1.6'
gem 'sass-rails', '~> 4.0.3'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.0.0'
gem 'jquery-rails'
gem 'turbolinks'
gem 'jbuilder', '~> 2.0'
gem 'sdoc', '~> 0.4.0',          group: :doc
gem 'spring',        group: :development

# Mongoid database
gem 'mongoid'
gem 'mongoid_search'

# SoundCloud
gem 'soundcloud'

# Server
gem 'bson_ext'
gem 'unicorn'

# Authentication
gem 'devise'
gem 'simple_token_authentication', github: 'rossfoley/simple_token_authentication'
gem 'json'

# Deployment
gem 'rails_12factor', group: :production

# Views
gem 'haml-rails'
gem 'twitter-bootstrap-rails'
gem 'devise-bootstrap-views'

group :development, :test do
  # Debugger
  gem 'byebug'

  # RSpec and related gems
  gem 'rspec-rails'
  gem 'factory_girl_rails'
  gem 'mongoid-rspec'
  gem 'database_cleaner'

  # Continuous test running
  gem 'guard-rspec', require: false
  gem 'terminal-notifier-guard'

  # Test coverage
  gem 'simplecov', require: false

  # Fake data generator
  gem 'faker'

  # Better error messages
  gem 'better_errors'
  gem 'binding_of_caller'

  # Support for Rails Chrome plugin
  gem 'meta_request'

  # Convert ERB to HAML
  gem 'erb2haml'
end

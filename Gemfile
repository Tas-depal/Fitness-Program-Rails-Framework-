source "https://rubygems.org"

git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.2.2"

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"

#.........manually added......................

gem 'byebug'
gem 'active_model_serializers'
gem 'rubocop', require: false
gem 'pundit'
gem 'devise'
gem 'jwt'
gem 'bcrypt'
gem 'activeadmin'
gem 'sass-rails'
gem 'redis'
gem "sidekiq", "~> 6.0.7"

gem "rails", "~> 7.0.6"

# Use sqlite3 as the database for Active Record
# gem "sqlite3", "~> 1.4"

# Use the Puma web server [https://github.com/puma/puma]
gem "puma", "~> 5.0"

gem 'twilio-ruby', '~> 6.8.2'

# Build JSON APIs with ease [https://github.com/rails/jbuilder]
# gem "jbuilder"

# Use Redis adapter to run Action Cable in production
# gem "redis", "~> 4.0"

# Use Kredis to get higher-level data types in Redis [https://github.com/rails/kredis]
# gem "kredis"

# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
# gem "bcrypt", "~> 3.1.7"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", require: false

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
# gem "image_processing", "~> 1.2"

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
gem "rack-cors"

# OmniAuth
gem 'omniauth'
gem 'omniauth-google-oauth2'
# gem 'oauth2', '~> 1.4.9'
gem 'omniauth-rails_csrf_protection', '~> 1.0'

# Stripe
gem 'stripe'

# Postgres
gem 'pg'

# Gem for swagger
gem 'rswag'
gem 'dotenv-rails'

# Gem active admin themes
gem 'active_admin_flat_skin'
gem 'font-awesome-rails'

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem "debug", platforms: %i[ mri mingw x64_mingw ]

  #For test cases
  gem 'rspec-rails'
  gem 'rswag-specs'
  gem 'factory_bot_rails'
  gem 'simplecov'
end

group :development do
  # Speed up commands on slow machines / big apps [https://github.com/rails/spring]
  # gem "spring"
  
  # Letter opener gem
  gem "letter_opener"
end


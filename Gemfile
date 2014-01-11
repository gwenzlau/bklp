source 'https://rubygems.org'

gem "rails", "~> 4.0.1"
gem 'sass-rails', '>= 3.2' # sass-rails needs to be higher than 3.2
gem 'bootstrap-sass', '~> 3.0.2.0'
gem 'jquery-rails'
gem 'devise'
gem 'simple_form'
gem 'paperclip', '~> 3.0'

gem 'openlibrary'
gem 'goodreads'

gem 'will_paginate', '~> 3.0'
gem "acts_as_follower"
gem 'public_activity'
gem 'acts_as_commentable'

gem 'aws-sdk'
gem 'newrelic_rpm'
#gem 'rails_admin'
#gem 'postmark-rails', '~> 0.5.2'


# Bundle edge Rails instead:

# gem 'rails', :git => 'git://github.com/rails/rails.git'

gem "actionmailer", "~> 4.0.1"


# Gems used only for assets and not required
# in production environments by default.

gem 'coffee-rails'


# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', :platforms => :ruby

gem 'uglifier', '>= 1.3.0'

# Add for Heroku
group :production do
	gem 'pg'
  gem 'rails_12factor'
end

group :development do
  gem 'quiet_assets'
  gem 'rack-mini-profiler'
end

group :development, :test do
  gem 'sqlite3'
  gem 'rspec-rails', '~> 2.0'
  gem 'shoulda-matchers', '~> 2.4'
end

group :test do
  gem 'factory_girl_rails'
  gem "faker", "~> 1.2.0"
end

gem 'dotenv-rails', :groups => [:development, :test]
# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

gem 'multi_json'

# Use unicorn as the app server
gem 'unicorn'
gem 'foreman'

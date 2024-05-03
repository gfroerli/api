source 'https://rubygems.org'

ruby File.read('.ruby-version').strip

gem 'administrate'
gem 'bootsnap', '>= 1.4.4', require: false
gem 'dotenv-rails'
gem 'jbuilder'
gem 'pg'
gem 'puma', '~> 6.4'
gem 'rack-contrib'
gem 'rack-cors', require: 'rack/cors'
gem 'rails', '~> 7.0.8'

group :development do
  gem 'listen', '~> 3.9'
end

group :development, :test do
  gem 'byebug'
  gem 'pry-rails'
  gem 'rubocop', require: false
  gem 'rubocop-performance', require: false
end

group :test do
  gem 'factory_bot_rails'
  gem 'mocha', '~> 2.2'
  gem 'simplecov', require: false
end

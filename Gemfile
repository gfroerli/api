source 'https://rubygems.org'

ruby File.read('.ruby-version').strip

gem 'administrate'
gem 'bootsnap', '>= 1.4.4', require: false
gem 'dotenv-rails'
gem 'jbuilder'
gem 'pg'
gem 'puma', '~> 5.6'
gem 'rack-contrib'
gem 'rack-cors', require: 'rack/cors'
gem 'rails', '~> 6.1.7'

group :development do
  gem 'listen', '~> 3.2'
  gem 'rubocop', require: false
  gem 'rubocop-performance', require: false
  gem 'spring', '~> 4.1'
  gem 'spring-watcher-listen', '~> 2.1'
end

group :development, :test do
  gem 'byebug'
  gem 'pry-rails'
end

group :test do
  gem 'factory_bot_rails'
  gem 'mocha', '~> 2.0'
  gem 'simplecov', require: false
end

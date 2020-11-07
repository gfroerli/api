source 'https://rubygems.org'

ruby File.read('.ruby-version').strip

gem 'bootsnap', '>= 1.4.4', require: false
gem 'dotenv-rails'
gem 'jbuilder'
gem 'pg'
gem 'rails'
gem 'puma'
gem 'rack-cors', require: 'rack/cors'

group :development do
  gem 'listen', '~> 3.2'
  gem 'rubocop', require: false
  gem 'rubocop-performance', require: false
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :development, :test do
  gem 'byebug'
  gem 'pry-rails'
end

group :test do
  gem 'factory_bot_rails'
  gem 'mocha'
  gem 'simplecov', require: false
end

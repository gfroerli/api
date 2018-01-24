source 'https://rubygems.org'

ruby File.read('.ruby-version').strip

gem 'dotenv-rails'
gem 'jbuilder'
gem 'pg', '~> 0.21'
gem 'rails', '~> 5.1.4'
gem 'redis', '~> 3.0'

gem 'puma'
gem 'rack-cors', require: 'rack/cors'

group :development do
  gem 'rubocop'
  gem 'spring'
end

group :development, :test do
  gem 'byebug'
  gem 'pry-rails'
  gem 'listen'
end

group :test do
  gem 'factory_bot_rails'
  gem 'mocha'
  gem 'simplecov', require: false
end

group :production do
  gem 'rails_12factor'
end

source 'https://rubygems.org'

ruby File.read('.ruby-version').strip

gem 'bootsnap', '>= 1.1.0', require: false
gem 'dotenv-rails'
gem 'jbuilder'
gem 'pg', '~> 0.21'
gem 'rails', '~> 5.2.0'
gem 'redis', '~> 3.0'

gem 'puma'
gem 'rack-cors', require: 'rack/cors'

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'rubocop'
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

group :production do
  gem 'rails_12factor'
end

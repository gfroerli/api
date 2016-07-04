source 'https://rubygems.org'

ruby File.read('.ruby-version').strip

gem 'rails', '~> 5.0'
gem 'pg'
gem 'redis', '~> 3.0'
gem 'jbuilder'
gem 'dotenv-rails'

gem 'puma'
gem 'rack-cors', :require => 'rack/cors'

group :development do
  gem 'spring'
  gem 'rubocop'
end

group :development, :test do
  gem 'byebug'
  gem 'pry-rails'
end

group :test do
  gem 'mocha'
  gem 'factory_girl_rails'
  gem 'simplecov', require: false
end

group :production do
  gem 'rails_12factor'
end
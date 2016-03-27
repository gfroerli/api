source 'https://rubygems.org'

ruby File.read('.ruby-version').strip

gem 'rails', '>= 5.0.0.beta3', '< 5.1'
gem 'pg'
gem 'redis', '~> 3.0'
gem 'jbuilder'
gem 'dotenv-rails'

gem 'puma'
gem 'rack-cors', :require => 'rack/cors'

gem 'particlerb', require: false

group :development do
  gem 'spring'
  gem 'rubocop'
end

group :development, :test do
  gem 'byebug'
end

group :test do
  gem 'mocha'
  gem 'factory_girl_rails'
  gem 'simplecov', require: false
end

source 'https://rubygems.org'

ruby File.read('.ruby-version').strip

gem 'dotenv-rails'
gem 'jbuilder'
gem 'pg', '~> 0.18'
gem 'rails', '~> 5.0.0'
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
end

group :test do
  gem 'factory_girl_rails'
  gem 'mocha'
  gem 'simplecov', require: false
end

group :production do
  gem 'rails_12factor'
end

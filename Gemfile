source 'https://rubygems.org'

ruby file: '.ruby-version'

gem 'administrate', '1.0.0'
gem 'bootsnap', '>= 1.4.4', require: false
gem 'dotenv-rails'
gem 'jbuilder'
gem 'pg'
gem 'propshaft'
gem 'puma', '~> 7.1'
gem 'rack-contrib'
gem 'rack-cors', require: 'rack/cors'
gem 'rails', '~> 8.1.2'

group :development do
  gem 'listen', '~> 3.10'
end

group :development, :test do
  gem 'byebug'
  gem 'minitest', '~> 5.18' # TODO: Remove once Rails supports Minitest 6
  gem 'pry-rails'
  gem 'rubocop', require: false
  gem 'rubocop-factory_bot', require: false
  gem 'rubocop-performance', require: false
  gem 'rubocop-rails', require: false
end

group :test do
  gem 'factory_bot_rails'
  gem 'mocha', '~> 3.0'
  gem 'simplecov', require: false
end

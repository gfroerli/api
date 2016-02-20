source 'https://rubygems.org'

ruby File.read('.ruby-version').strip

gem 'rails', '>= 5.0.0.beta2', '< 5.1'
gem 'pg'
gem 'puma'
gem 'redis', '~> 3.0'

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
# gem 'rack-cors'

group :development, :test do
  gem 'byebug'
  gem 'factory_girl_rails'
end

group :development do
  gem 'spring'
  gem 'rubocop'
end

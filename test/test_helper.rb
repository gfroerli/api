ENV['RAILS_ENV'] ||= 'test'

require 'simplecov'
SimpleCov.minimum_coverage 100
SimpleCov.start 'rails'

require File.expand_path('../config/environment', __dir__)
require 'rails/test_help'
require 'mocha/minitest'

module ActiveSupport
  class TestCase
    include FactoryBot::Syntax::Methods
  end
end

def public_auth_header
  api_key = ActionController::HttpAuthentication::Token.encode_credentials(
    create(:api_consumer).public_api_key
  )
  { authorization: api_key }
end

def private_auth_header
  api_key = ActionController::HttpAuthentication::Token.encode_credentials(
    create(:private_api_consumer).private_api_key
  )
  { authorization: api_key }
end

def admin_auth_header
  api_consumer = create(:private_api_consumer)
  { Authorization: ActionController::HttpAuthentication::Basic.encode_credentials(
    api_consumer.public_api_key, api_consumer.private_api_key
  ) }
end

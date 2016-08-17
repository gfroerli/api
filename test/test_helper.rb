# frozen_string_literal: true
ENV['RAILS_ENV'] ||= 'test'

require 'simplecov'
SimpleCov.minimum_coverage 100
SimpleCov.start 'rails'

require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'mocha/mini_test'

module ActiveSupport
  class TestCase
    include FactoryGirl::Syntax::Methods
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

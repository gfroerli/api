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

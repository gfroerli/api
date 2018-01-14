
# frozen_string_literal: true

require 'test_helper'

class ApplicationCableTest < ActiveSupport::TestCase
  test 'connection can be used' do
    ApplicationCable::Connection
  end

  test 'that channel can be extended' do
    class SampleChannel < ApplicationCable::Channel; end
  end
end

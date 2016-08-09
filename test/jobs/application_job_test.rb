# frozen_string_literal: true
require 'test_helper'

class ApplicationJobTest < ActiveJob::TestCase
  test 'that job can be extended' do
    class SampleJob < ApplicationJob; end
  end
end

require 'test_helper'

class ApplicationMailerTest < ActionMailer::TestCase
  test 'should load the configuration' do
    class SampleMailer < ApplicationMailer; end
  end
end

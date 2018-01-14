
# frozen_string_literal: true

require 'test_helper'

class ApplicationMailerTest < ActionMailer::TestCase
  test 'that mailer can be extended' do
    class SampleMailer < ApplicationMailer; end
  end
end

require 'test_helper'

class SensorTest < ActiveSupport::TestCase
  test 'it can instantiate' do
    create(:sensor)
  end
end

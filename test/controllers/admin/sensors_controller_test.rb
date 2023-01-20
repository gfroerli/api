require 'test_helper'

class SensorControllerTest < ActionDispatch::IntegrationTest
  setup do
    @headers = admin_auth_header
  end

  test 'should get unauthorized without authentication' do
    get admin_sensors_url
    assert_response :unauthorized
  end

  test 'should get success with authentication' do
    get admin_sensors_url, headers: @headers
    assert_response :success
  end
end

require 'test_helper'

class ApiConsumersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @headers = admin_auth_header
  end

  test 'should get unauthorized without authentication' do
    get admin_api_consumers_url
    assert_response :unauthorized
  end

  test 'should get success with authentication' do
    get admin_api_consumers_url, headers: @headers
    assert_response :success
  end
end

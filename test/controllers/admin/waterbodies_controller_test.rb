require 'test_helper'

class WaterbodiesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @headers = admin_auth_header
  end

  test 'should get unauthorized without authentication' do
    get admin_waterbodies_url
    assert_response :unauthorized
  end

  test 'should get success with authentication' do
    get admin_waterbodies_url, headers: @headers
    assert_response :success
    assert_includes @response.body, 'Waterbodies'
  end

  test 'show an existing waterbody' do
    waterbody = create(:waterbody, name: 'Zürichsee')
    get admin_waterbody_url(waterbody), headers: @headers
    assert_includes @response.body, "Show #{waterbody.name}"
  end
end

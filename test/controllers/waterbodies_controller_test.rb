require 'test_helper'

class WaterbodiesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @waterbody = create(:waterbody)
  end

  test 'should get unauthorized without auth header' do
    get waterbodies_url
    assert_response :unauthorized
  end

  test 'should get index' do
    get waterbodies_url, env: public_auth_header
    assert_response :success
    response_object = JSON.parse(response.body)
    assert response_object.length == 1
    assert response_object[0]['name'] == @waterbody.name
  end

  test 'get an individual waterbody' do
    get waterbody_url(@waterbody), env: public_auth_header
    assert_response :success
    response_object = JSON.parse(response.body)
    assert response_object['name'] == @waterbody.name
  end
end

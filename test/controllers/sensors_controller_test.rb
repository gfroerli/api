require 'test_helper'

class SensorsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @sensor = create(:sensor)
  end

  test 'should get index' do
    get sensors_url, env: public_auth_header
    assert_response :success
  end

  test 'should get the last measurement with each sensor' do
    @sensor.measurements << create(:measurement)
    get sensors_url, env: public_auth_header
    assert_not_empty(JSON.parse(response.body).first['last_measurement'])
  end

  test 'should show sensor' do
    get sensor_url(@sensor), env: public_auth_header
    assert_response :success
    assert_equal JSON.parse(response.body).keys,
                 %w[id device_name caption latitude longitude sponsor_id created_at updated_at]
  end

  test 'should create sensor' do
    assert_difference('Sensor.count') do
      post sensors_url, params: { sensor: { caption: @sensor.caption, device_name: @sensor.device_name,
                                            latitude: @sensor.latitude, longitude: @sensor.longitude,
                                            sponsor_id: @sensor.sponsor.id } },
                        env: private_auth_header
    end

    assert_response 201
  end

  test 'should update sensor' do
    patch sensor_url(@sensor), params: { sensor: { caption: @sensor.caption, device_name: @sensor.device_name,
                                                   latitude: @sensor.latitude, longitude: @sensor.longitude,
                                                   sponsor_id: @sensor.sponsor.id } },
                               env: private_auth_header
    assert_response 200
  end

  test 'should destroy sensor' do
    assert_difference('Sensor.count', -1) do
      delete sensor_url(@sensor), env: private_auth_header
    end

    assert_response 204
  end

  class FlawedSensorsControllerTest < ActionDispatch::IntegrationTest
    setup do
      @sensor = create(:sensor)
      Sensor.any_instance.stubs(:save).returns(false)
    end

    test 'should NOT create sensor' do
      assert_no_difference('Sensor.count') do
        post sensors_url, params: { sensor: { blub: 'gach' } }, env: private_auth_header
      end

      assert_response 422
    end

    test 'should NOT update sensor' do
      patch sensor_url(@sensor), params: { sensor: { blub: 'gach' } }, env: private_auth_header
      assert_response 422
    end
  end
end

# frozen_string_literal: true
require 'test_helper'

class SensorsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @sensor = create(:sensor)
    ApplicationController.class_eval do
      def require_private_access!; end
    end
  end

  test 'should get index' do
    get sensors_url
    assert_response :success
  end

  test 'should create sensor' do
    assert_difference('Sensor.count') do
      post sensors_url, params: { sensor: { caption: @sensor.caption, device_name: @sensor.device_name,
                                            location: @sensor.location, sponsor_id: @sensor.sponsor.id } }
    end

    assert_response 201
  end

  test 'should show sensor' do
    get sensor_url(@sensor)
    assert_response :success
  end

  test 'should update sensor' do
    patch sensor_url(@sensor), params: { sensor: { caption: @sensor.caption, device_name: @sensor.device_name,
                                                   location: @sensor.location, sponsor_id: @sensor.sponsor.id } }
    assert_response 200
  end

  test 'should destroy sensor' do
    assert_difference('Sensor.count', -1) do
      delete sensor_url(@sensor)
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
        post sensors_url, params: { sensor: { blub: 'gach' } }
      end

      assert_response 422
    end

    test 'should NOT update sensor' do
      patch sensor_url(@sensor), params: { sensor: { blub: 'gach' } }
      assert_response 422
    end
  end
end

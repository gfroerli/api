# frozen_string_literal: true
require 'test_helper'

class MeasurementsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @measurement = create(:measurement)
  end

  test 'should show measurement' do
    get measurement_url(@measurement), env: public_auth_header
    assert_response :success
  end

  test 'should get index' do
    get measurements_url, params: nil, env: public_auth_header
    assert_response :success
  end

  test 'should get index using filters' do
    create_list(:measurement, 4)

    get measurements_url, params: { sensor_id: Measurement.pluck(:sensor_id), last: 2 },
                          env: public_auth_header
    assert_response :success
    measurements = JSON.parse(response.body)

    assert_equal(2, measurements.count)
  end

  test 'should get index using partition filters' do
    sensor_a = create(:sensor)
    sensor_b = create(:sensor)
    create_list(:measurement, 4, sensor: sensor_a)
    create_list(:measurement, 3, sensor: sensor_b)

    get measurements_url, params: { last_per_sensor: 2, last: 3 }, env: public_auth_header
    assert_response :success
    measurements = JSON.parse(response.body)

    assert_equal(3, measurements.count)
    assert_equal(sensor_a.id, measurements.first['sensor_id'])
    assert_equal(sensor_b.id, measurements.second['sensor_id'])
    assert_equal(sensor_b.id, measurements.third['sensor_id'])
  end

  test 'should create measurement' do
    assert_difference('Measurement.count') do
      post measurements_url, params: { measurement: { custom_attributes: @measurement.custom_attributes,
                                                      sensor_id: @measurement.sensor.id,
                                                      temperature: @measurement.temperature } },
                             env: private_auth_header
    end

    assert_response 201
  end

  test 'should update measurement' do
    patch measurement_url(@measurement), params: { measurement: { custom_attributes: @measurement.custom_attributes,
                                                                  sensor_id: @measurement.sensor.id,
                                                                  temperature: @measurement.temperature } },
                                         env: private_auth_header
    assert_response 200
  end

  test 'should destroy measurement' do
    assert_difference('Measurement.count', -1) do
      delete measurement_url(@measurement), env: private_auth_header
    end

    assert_response 204
  end

  class FlawedMeasurementsControllerTest < ActionDispatch::IntegrationTest
    setup do
      @measurement = create(:measurement)
      Measurement.any_instance.stubs(:save).returns(false)
    end

    test 'should NOT create measurement' do
      assert_no_difference('Measurement.count') do
        post measurements_url, params: { measurement: { blub: 'gach' } }, env: private_auth_header
      end

      assert_response 422
    end

    test 'should NOT update measurement' do
      patch measurement_url(@measurement), params: { measurement: { blub: 'gach' } },
                                           env: private_auth_header
      assert_response 422
    end
  end
end

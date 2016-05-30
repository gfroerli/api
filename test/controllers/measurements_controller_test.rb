require 'test_helper'

class MeasurementsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @measurement = create(:measurement)
  end

  test 'should get index' do
    get measurements_url
    assert_response :success
  end

  test 'should get index using filters' do
    create_list(:measurement, 4)
    get measurements_url, params: {sensor_id: Measurement.pluck(:sensor_id), last: 2}
    assert_response :success
    measurements = JSON.parse(response.body)
    assert_equal(2, measurements.count)
  end

  test 'should create measurement' do
    assert_difference('Measurement.count') do
      post measurements_url, params: { measurement: { custom_attributes: @measurement.custom_attributes,
                                                      sensor_id: @measurement.sensor.id,
                                                      temperature: @measurement.temperature } }
    end

    assert_response 201
  end

  test 'should show measurement' do
    get measurement_url(@measurement)
    assert_response :success
  end

  test 'should update measurement' do
    patch measurement_url(@measurement), params: { measurement: { custom_attributes: @measurement.custom_attributes,
                                                                  sensor_id: @measurement.sensor.id,
                                                                  temperature: @measurement.temperature } }
    assert_response 200
  end

  test 'should destroy measurement' do
    assert_difference('Measurement.count', -1) do
      delete measurement_url(@measurement)
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
        post measurements_url, params: { measurement: { blub: 'gach' } }
      end

      assert_response 422
    end

    test 'should NOT update measurement' do
      patch measurement_url(@measurement), params: { measurement: { blub: 'gach' } }
      assert_response 422
    end
  end
end

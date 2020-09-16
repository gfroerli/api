require 'test_helper'

def measurements
  JSON.parse(response.body)
end

class MeasurementsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @measurement = create(:measurement)
  end

  test 'should NOT show measurement if unauthorized' do
    get measurement_url(@measurement)
    assert_response :unauthorized
  end

  test 'should show measurement' do
    get measurement_url(@measurement), env: public_auth_header
    assert_response :success
  end

  test 'should get index' do
    get measurements_url, params: nil, env: public_auth_header
    assert_response :success
  end

  test 'should create measurement' do
    assert_difference('Measurement.count') do
      post measurements_url, params: { measurement: { custom_attributes: @measurement.custom_attributes,
                                                      sensor_id: @measurement.sensor.id,
                                                      temperature: @measurement.temperature } },
                             env: private_auth_header
    end

    new_measurements = Measurement.last

    assert_equal(@measurement.custom_attributes, new_measurements.custom_attributes)
    assert_equal(@measurement.sensor, new_measurements.sensor)
    assert_equal(@measurement.temperature, new_measurements.temperature)

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

  class FilterMeasurementsControllerTest < ActionDispatch::IntegrationTest
    test 'should get index using filters' do
      create_list(:measurement, 4)

      get measurements_url, params: { sensor_id: Measurement.pluck(:sensor_id), last: 2 },
                            env: public_auth_header
      assert_response :success
      assert_equal(2, measurements.count)
    end

    test 'should get index using partition filters' do
      sensor_a = create(:sensor)
      sensor_b = create(:sensor)
      create_list(:measurement, 4, sensor: sensor_a)
      create_list(:measurement, 3, sensor: sensor_b)

      get measurements_url, params: { last_per_sensor: 2, last: 3 }, env: public_auth_header
      assert_response :success

      assert_equal(3, measurements.count)
      assert_equal(sensor_a.id, measurements.first['sensor_id'])
      assert_equal(sensor_b.id, measurements.second['sensor_id'])
      assert_equal(sensor_b.id, measurements.third['sensor_id'])
    end

    test 'should apply date filters' do
      m1 = create(:measurement, created_at: 2.days.ago)
      m2 = create(:measurement, created_at: 5.days.ago)

      get measurements_url, params: { created_after: 3.days.ago, created_before: 1.day.ago }, env: public_auth_header
      assert_equal(1, measurements.count)
      assert_equal(m1.id, measurements.first['id'])

      get measurements_url, params: { created_before: 1.day.ago }, env: public_auth_header
      assert_equal(2, measurements.count)
      assert_equal(m2.id, measurements.first['id'])
      assert_equal(m1.id, measurements.second['id'])

      get measurements_url, params: { created_after: 1.day.ago }, env: public_auth_header
      assert_equal(0, measurements.count)
    end

    test 'should filter in UTC if given CET' do
      m1 = create(:measurement, created_at: '2018-01-29T20:02:00+01:00') # 20:02 in Rapperswil

      get measurements_url, params: { created_after: '2018-01-29T20:00:00+01:00',
                                      created_before: '2018-01-29T20:04:00+01:00' },
                            env: public_auth_header

      assert_equal(1, measurements.count)
      assert_equal(m1.id, measurements.first['id'])
      assert_equal(m1.created_at, Time.zone.iso8601(measurements.first['created_at']))
    end

    test 'should not stumble over garbage numbers in the parameters' do
      create_list(:measurement, 4)

      get measurements_url, params: { last: 'garbage' }, env: public_auth_header
      assert_response :success
      assert_equal(0, measurements.count)

      get measurements_url, params: { last_per_sensor: 'garbage' }, env: public_auth_header
      assert_response :success
      assert_equal(0, measurements.count)
    end
  end

  class AggregateMeasurementsControllerTest < ActionDispatch::IntegrationTest
    test 'should return average, minimum and maximum' do
      create :measurement, temperature: 1, created_at: 1.day.ago
      create :measurement, temperature: 2, created_at: 2.days.ago
      create :measurement, temperature: 3, created_at: 2.days.ago
      create :measurement, temperature: 1, created_at: 3.days.ago
      create :measurement, temperature: 1, created_at: 3.days.ago

      get aggregated_measurements_url, env: public_auth_header
      aggregated_numbers = JSON.parse(response.body)
      assert_response :success

      assert_equal(3, aggregated_numbers['minimum_temperature'].count)
      assert_equal(3, aggregated_numbers['maximum_temperature'].count)
      assert_equal(3, aggregated_numbers['average_temperature'].count)

      assert_equal('2.0', aggregated_numbers['minimum_temperature'][2.days.ago.to_date.iso8601])
      assert_equal('3.0', aggregated_numbers['maximum_temperature'][2.days.ago.to_date.iso8601])
      assert_equal('2.5', aggregated_numbers['average_temperature'][2.days.ago.to_date.iso8601])
    end
  end
end

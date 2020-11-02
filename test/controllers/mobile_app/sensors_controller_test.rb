require 'test_helper'

def parsed_response
  JSON.parse(response.body)
end

module MobileApp
  class SensorsControllerTest < ActionDispatch::IntegrationTest
    setup do
      @sensor = create(:sensor)
    end

    test 'should get index with latest measurement' do
      @sensor.measurements << create(:measurement, temperature: 20)

      get mobile_app_sensors_url, env: public_auth_header

      assert_response :success
      assert_equal(parsed_response.first['latest_temperature'], 20)
    end

    test 'should show sensor with minimum, maximum and average temperature' do
      @sensor.measurements << create(:measurement, temperature: 3)
      @sensor.measurements << create(:measurement, temperature: 10)
      @sensor.measurements << create(:measurement, temperature: 20)

      get mobile_app_sensor_url(@sensor), env: public_auth_header

      assert_response :success
      assert_equal(parsed_response['minimum_temperature'], 3)
      assert_equal(parsed_response['maximum_temperature'], 20)
      assert_equal(parsed_response['average_temperature'], 11)
    end

    test 'should show aggregated temperatures' do
      @sensor.measurements << create(:measurement, created_at: DateTime.parse('2020-09-09'), temperature: 5)
      @sensor.measurements << create(:measurement, created_at: DateTime.parse('2020-09-09'), temperature: 10)
      @sensor.measurements << create(:measurement, created_at: DateTime.parse('2020-09-10'), temperature: 20)
      @sensor.measurements << create(:measurement, created_at: DateTime.parse('2020-09-10'), temperature: 30)

      get daily_temperatures_mobile_app_sensor_url(@sensor), env: public_auth_header

      assert_response :success
      assert_equal(parsed_response.length, 2)

      assert_equal(parsed_response.first['aggregation_date'], '2020-09-10')
      assert_equal(parsed_response.first['minimum_temperature'], 20)
      assert_equal(parsed_response.first['maximum_temperature'], 30)
      assert_equal(parsed_response.first['average_temperature'], 25)

      assert_equal(parsed_response.second['aggregation_date'], '2020-09-09')
      assert_equal(parsed_response.second['minimum_temperature'], 5)
      assert_equal(parsed_response.second['maximum_temperature'], 10)
      assert_equal(parsed_response.second['average_temperature'], 7.5)
    end

    test 'should filter aggregated temperatures by date' do
      @sensor.measurements << create(:measurement, created_at: DateTime.parse('2020-09-09'), temperature: 5)
      @sensor.measurements << create(:measurement, created_at: DateTime.parse('2020-09-09'), temperature: 10)
      @sensor.measurements << create(:measurement, created_at: DateTime.parse('2020-09-10'), temperature: 20)
      @sensor.measurements << create(:measurement, created_at: DateTime.parse('2020-09-10'), temperature: 30)
      @sensor.measurements << create(:measurement, created_at: DateTime.parse('2020-09-11'), temperature: 30)

      open_start_filter = { to: '2020-09-10' }
      get daily_temperatures_mobile_app_sensor_url(@sensor, open_start_filter), env: public_auth_header
      assert_equal(2, parsed_response.length)
      assert_equal('2020-09-10', parsed_response.first['aggregation_date'])
      assert_equal('2020-09-09', parsed_response.second['aggregation_date'])

      open_end_filter = { from: '2020-09-10' }
      get daily_temperatures_mobile_app_sensor_url(@sensor, open_end_filter), env: public_auth_header
      assert_equal(2, parsed_response.length)
      assert_equal('2020-09-11', parsed_response.first['aggregation_date'])
      assert_equal('2020-09-10', parsed_response.second['aggregation_date'])

      both_ends_filter = { to: '2020-09-10', from: '2020-09-10' }
      get daily_temperatures_mobile_app_sensor_url(@sensor, both_ends_filter), env: public_auth_header
      assert_equal(1, parsed_response.length)
      assert_equal('2020-09-10', parsed_response.first['aggregation_date'])
    end

    test 'should filter aggregated temperatures by limit' do
      @sensor.measurements << create(:measurement, created_at: DateTime.parse('2020-09-01'), temperature: 5)
      @sensor.measurements << create(:measurement, created_at: DateTime.parse('2020-09-02'), temperature: 10)
      @sensor.measurements << create(:measurement, created_at: DateTime.parse('2020-09-03'), temperature: 20)

      limit_filter = { limit: '2' }
      get daily_temperatures_mobile_app_sensor_url(@sensor, limit_filter), env: public_auth_header
      assert_equal(2, parsed_response.length)
      assert_equal('2020-09-03', parsed_response.first['aggregation_date'])
      assert_equal('2020-09-02', parsed_response.second['aggregation_date'])
    end

    test 'should show active sponsor of a sensor' do
      create(:sponsor, active: true, sensors: [@sensor])

      get sponsor_mobile_app_sensor_url(@sensor), env: public_auth_header

      assert_response :success
      assert_equal(parsed_response['id'], @sensor.sponsor.id)
    end

    test 'should NOT show inactive sponsor of a sensor' do
      create(:sponsor, active: false, sensors: [@sensor])

      get sponsor_mobile_app_sensor_url(@sensor), env: public_auth_header

      assert_response :not_found
    end
  end
end

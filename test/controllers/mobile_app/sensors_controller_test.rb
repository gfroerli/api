require 'test_helper'

def parsed_response
  JSON.parse(response.body)
end

module MobileApp
  class SensorsControllerTest < ActionDispatch::IntegrationTest
    setup do
      @sensor = create(:sensor)
    end

    test 'should get sensor index with latest measurement' do
      @sensor.measurements << create(:measurement, temperature: 20, created_at: Time.zone.parse('2020-08-08'))

      get mobile_app_sensors_url, env: public_auth_header

      assert_response :success
      assert_equal(20, parsed_response.first['latest_temperature'])
      assert_equal(1_596_844_800, parsed_response.first['latest_measurement_at']) # 2020-08-08
      assert_equal(@sensor.sponsor.id, parsed_response.first['sponsor_id'])
    end

    test 'should show sensor with minimum, maximum and average temperature' do
      @sensor.measurements << create(:measurement, temperature: 3, created_at: Time.zone.parse('2020-08-08 08:00:00'))
      @sensor.measurements << create(:measurement, temperature: 10, created_at: Time.zone.parse('2020-08-08 08:00:02'))
      @sensor.measurements << create(:measurement, temperature: 20, created_at: Time.zone.parse('2020-08-08 08:00:01'))

      get mobile_app_sensor_url(@sensor), env: public_auth_header

      assert_response :success
      assert_equal(parsed_response['latest_measurement_at'], 1_596_873_602) # 2020-08-08 08:00:02
      assert_equal(parsed_response['minimum_temperature'], 3)
      assert_equal(parsed_response['maximum_temperature'], 20)
      assert_equal(parsed_response['average_temperature'], 11)
    end

    test 'should show sensor detail even if there are no measurements' do
      get mobile_app_sensor_url(@sensor), env: public_auth_header

      assert_response :success
      assert_equal(@sensor.id, parsed_response['id'])
      assert_nil(parsed_response['minimum_temperature'])
      assert_nil(parsed_response['maximum_temperature'])
      assert_nil(parsed_response['average_temperature'])
    end

    test 'should show daily aggregated temperatures' do
      @sensor.measurements << create(:measurement, created_at: Time.zone.parse('2020-09-09'), temperature: 5)
      @sensor.measurements << create(:measurement, created_at: Time.zone.parse('2020-09-09'), temperature: 10)
      @sensor.measurements << create(:measurement, created_at: Time.zone.parse('2020-09-10'), temperature: 20)
      @sensor.measurements << create(:measurement, created_at: Time.zone.parse('2020-09-10'), temperature: 30)

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

    test 'should show hourly aggregated temperatures' do
      @sensor.measurements << create(:measurement, created_at: Time.zone.parse('2020-09-09 00:01'), temperature: 5)
      @sensor.measurements << create(:measurement, created_at: Time.zone.parse('2020-09-09 00:05'), temperature: 10)
      @sensor.measurements << create(:measurement, created_at: Time.zone.parse('2020-09-09 03:03'), temperature: 20)
      @sensor.measurements << create(:measurement, created_at: Time.zone.parse('2020-09-09 03:59'), temperature: 28)
      @sensor.measurements << create(:measurement, created_at: Time.zone.parse('2020-09-10 00:59'), temperature: 30)

      get hourly_temperatures_mobile_app_sensor_url(@sensor), env: public_auth_header

      assert_response :success
      assert_equal(3, parsed_response.length)

      assert(parsed_response.first['aggregation_date'].is_a?(String))
      assert(parsed_response.first['aggregation_hour'].is_a?(Integer))
      assert(parsed_response.first['minimum_temperature'].is_a?(Float))
      assert(parsed_response.first['maximum_temperature'].is_a?(Float))
      assert(parsed_response.first['average_temperature'].is_a?(Float))

      assert_equal(parsed_response.first['aggregation_date'], '2020-09-10')
      assert_equal(parsed_response.first['aggregation_hour'], 0)
      assert_equal(parsed_response.first['minimum_temperature'], 30)
      assert_equal(parsed_response.first['maximum_temperature'], 30)
      assert_equal(parsed_response.first['average_temperature'], 30)

      assert_equal(parsed_response.second['aggregation_date'], '2020-09-09')
      assert_equal(parsed_response.second['aggregation_hour'], 3)
      assert_equal(parsed_response.second['minimum_temperature'], 20)
      assert_equal(parsed_response.second['maximum_temperature'], 28)
      assert_equal(parsed_response.second['average_temperature'], 24)

      assert_equal(parsed_response.third['aggregation_date'], '2020-09-09')
      assert_equal(parsed_response.third['aggregation_hour'], 0)
      assert_equal(parsed_response.third['minimum_temperature'], 5)
      assert_equal(parsed_response.third['maximum_temperature'], 10)
      assert_equal(parsed_response.third['average_temperature'], 7.5)
    end

    test 'should filter aggregated temperatures by date' do
      @sensor.measurements << create(:measurement, created_at: Time.zone.parse('2020-09-09'), temperature: 5)
      @sensor.measurements << create(:measurement, created_at: Time.zone.parse('2020-09-09'), temperature: 10)
      @sensor.measurements << create(:measurement, created_at: Time.zone.parse('2020-09-10'), temperature: 20)
      @sensor.measurements << create(:measurement, created_at: Time.zone.parse('2020-09-10'), temperature: 30)
      @sensor.measurements << create(:measurement, created_at: Time.zone.parse('2020-09-11'), temperature: 30)

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
      @sensor.measurements << create(:measurement, created_at: Time.zone.parse('2020-09-01'), temperature: 5)
      @sensor.measurements << create(:measurement, created_at: Time.zone.parse('2020-09-02'), temperature: 10)
      @sensor.measurements << create(:measurement, created_at: Time.zone.parse('2020-09-03'), temperature: 20)

      limit_filter = { limit: '2' }
      get daily_temperatures_mobile_app_sensor_url(@sensor, limit_filter), env: public_auth_header
      assert_equal(2, parsed_response.length)
      assert_equal('2020-09-03', parsed_response.first['aggregation_date'])
      assert_equal('2020-09-02', parsed_response.second['aggregation_date'])
    end

    test 'should show active sponsor of a sensor' do
      create(:sponsor, active: true, logo_source: 'hsr.svg', sensors: [@sensor])

      get sponsor_mobile_app_sensor_url(@sensor), env: public_auth_header

      assert_response :success
      assert_equal(parsed_response['id'], @sensor.sponsor.id)
      assert_includes(parsed_response['logo_url'], @sensor.sponsor.logo_source)
    end

    test 'should NOT show inactive sponsor of a sensor' do
      create(:sponsor, active: false, sensors: [@sensor])

      get sponsor_mobile_app_sensor_url(@sensor), env: public_auth_header
      assert_response :not_found
    end
  end
end

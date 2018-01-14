
# frozen_string_literal: true

require 'test_helper'

class MeasurementTest < ActiveSupport::TestCase
  def create_nine_sensor_measurements
    create_list(:measurement, 3, sensor: create(:sensor))
    create_list(:measurement, 3, sensor: create(:sensor))
    create_list(:measurement, 3, sensor: create(:sensor))
  end

  test 'should scope measurements per sensor' do
    create_nine_sensor_measurements
    measurements = Measurement.last_per_sensor(2).to_a
    assert_equal(6, measurements.count)
  end

  test 'should scope measurements per sensor with limit (9 present, grouped by 4)' do
    create_nine_sensor_measurements
    measurements = Measurement.last_per_sensor(4).to_a
    assert_equal(9, measurements.count)
  end
end

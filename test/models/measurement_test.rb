require 'test_helper'

class MeasurementTest < ActiveSupport::TestCase
  test 'should scope measurements per sensor' do
    create_list(:measurement, 3, sensor: create(:sensor))
    create_list(:measurement, 3, sensor: create(:sensor))
    create_list(:measurement, 3, sensor: create(:sensor))

    measurements = Measurement.last_per_sensor(2).to_a
    assert_equal(6, measurements.count)
  end
end

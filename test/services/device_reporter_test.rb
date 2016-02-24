require 'test_helper'

class DeviceReporterTest < ActiveSupport::TestCase
  setup do
    @reporter = DeviceReporter.new('device01', [{temperature: 5.4, voltage: 2.17}, {temperature: 5.12, voltage: 2.18}])
  end
  
  test 'should initialize' do
    assert_difference 'Measurement.count', 2 do
      @reporter.submit!
    end
  end

  test 'should add data' do
    @reporter.add_data({temperature: 5.05, voltage: 2.16})

    assert_difference 'Measurement.count', 3 do
      @reporter.submit!
    end
  end
end

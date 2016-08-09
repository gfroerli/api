# frozen_string_literal: true
require 'test_helper'

class RawEventReporterTest < ActiveSupport::TestCase
  setup do
    @reporter = RawEventReporter.new
    @event = OpenStruct.new data: 't1=23860,v=3.789,c=63.5',
                            published_at: '2016-05-16T16:17:42.638Z',
                            coreid: '4a005b001451343334363036'
  end

  test 'should report measurement for new sensor' do
    assert_difference 'Sensor.count', 1 do
      assert_difference 'Measurement.count', 5 do
        5.times { @reporter.report!(@event) }
      end
    end
  end

  test 'should report measurement for already existing sensor' do
    sensor = create(:sensor)

    assert_no_difference 'Sensor.count' do
      assert_difference 'sensor.measurements.count', 3 do
        @event.coreid = sensor.device_name
        3.times { @reporter.report!(@event) }
      end
    end
  end
end

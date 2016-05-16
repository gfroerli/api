require 'test_helper'

class DeviceReporterTest < ActiveSupport::TestCase
  setup do
    @reporter = DeviceReporter.new('device01')
  end

  test 'should report' do
    assert_difference 'Measurement.count', 1 do
      event = OpenStruct.new data: 't1=23860,v=3.789,c=63.5',
                             published_at: '2016-05-16T16:17:42.638Z',
                             coreid: '4a005b001451343334363036'
      @reporter.report!(event)
    end
  end
end

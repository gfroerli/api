require 'test_helper'

class WaterbodyTest < ActiveSupport::TestCase
  test 'should nullify sensor waterbody references on destroy' do
    sensor = create(:sensor)
    waterbody = create(:waterbody, sensors: [sensor])
    assert_equal sensor.waterbody, waterbody
    waterbody.destroy
    assert_nil sensor.reload.waterbody
  end
end

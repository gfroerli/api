require 'test_helper'

class SponsorTest < ActiveSupport::TestCase
  test 'it can instantiate' do
    create(:sponsor)
  end
end

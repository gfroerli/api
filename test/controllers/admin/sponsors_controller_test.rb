require 'test_helper'

class SponsorsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @headers = admin_auth_header
  end

  test 'should get unauthorized without authentication' do
    get admin_sponsors_url
    assert_response :unauthorized
  end

  test 'should get success with authentication' do
    get admin_sponsors_url, headers: @headers
    assert_response :success
    assert_includes @response.body, 'Sponsors'
  end

  test 'show an existing sponsor' do
    sponsor = create(:sponsor, name: 'OST')
    get admin_sponsor_url(sponsor), headers: @headers
    assert_includes @response.body, "Show #{sponsor.name}"
  end

  test 'new sponsor form includes sponsor_type field' do
    get new_admin_sponsor_url, headers: @headers
    assert_response :success
    assert_includes @response.body, 'sponsor_type'
  end
end

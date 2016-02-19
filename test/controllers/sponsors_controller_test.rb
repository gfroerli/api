require 'test_helper'

class SponsorsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @sponsor = create(:sponsor)
  end

  test "should get index" do
    get sponsors_url
    assert_response :success
  end

  test "should create sponsor" do
    assert_difference('Sponsor.count') do
      post sponsors_url, params: { sponsor: { active: @sponsor.active, description: @sponsor.description, name: @sponsor.name } }
    end

    assert_response 201
  end

  test "should show sponsor" do
    get sponsor_url(@sponsor)
    assert_response :success
  end

  test "should update sponsor" do
    patch sponsor_url(@sponsor), params: { sponsor: { active: @sponsor.active, description: @sponsor.description, name: @sponsor.name } }
    assert_response 200
  end

  test "should destroy sponsor" do
    assert_difference('Sponsor.count', -1) do
      delete sponsor_url(@sponsor)
    end

    assert_response 204
  end
end

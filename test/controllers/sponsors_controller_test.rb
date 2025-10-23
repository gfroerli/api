require 'test_helper'

class SponsorsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @sponsor = create(:sponsor)
  end

  test 'should get index' do
    get sponsors_url, env: public_auth_header
    assert_response :success
  end

  test 'should show sponsor' do
    get sponsor_url(@sponsor), env: public_auth_header
    assert_response :success
  end

  test 'should create sponsor' do
    assert_difference('Sponsor.count') do
      post sponsors_url, params: { sponsor: { active: @sponsor.active,
                                              description: @sponsor.description,
                                              name: @sponsor.name } },
                         env: private_auth_header
    end

    assert_response :created
  end

  test 'should update sponsor' do
    patch sponsor_url(@sponsor), params: { sponsor: { active: @sponsor.active,
                                                      description: @sponsor.description,
                                                      name: @sponsor.name } },
                                 env: private_auth_header
    assert_response :ok
  end

  test 'should destroy sponsor' do
    assert_difference('Sponsor.count', -1) do
      delete sponsor_url(@sponsor), env: private_auth_header
    end

    assert_response :no_content
  end

  class FlawedSponsorsControllerTest < ActionDispatch::IntegrationTest
    setup do
      @sponsor = create(:sponsor)
    end

    test 'with invalid attributes should NOT create sponsor' do
      assert_no_difference('Sponsor.count') do
        post sponsors_url, params: { sponsor: { active: true } }, env: private_auth_header
      end

      assert_response :unprocessable_content
    end

    test 'with invalid attributes should NOT update sponsor' do
      patch sponsor_url(@sponsor), params: { sponsor: { name: nil } }, env: private_auth_header
      assert_response :unprocessable_content
    end

    test 'with non-allowed attributes should NOT create sponsor' do
      assert_no_difference('Sponsor.count') do
        post sponsors_url, params: { sponsor: { blub: 'gach' } }, env: private_auth_header
      end

      assert_response :bad_request
    end

    test 'with non-allowed attributes should NOT update sponsor' do
      patch sponsor_url(@sponsor), params: { sponsor: { blub: 'gach' } }, env: private_auth_header
      assert_response :bad_request
    end
  end
end

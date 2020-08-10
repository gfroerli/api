require 'test_helper'

class SponsorImagesControllerTest < ActionDispatch::IntegrationTest
  def image_file
    fixture_file_upload('files/logo.png', 'image/png')
  end

  setup do
    @sponsor_image = SponsorImage.create(sponsor: create(:sponsor), file: image_file)
  end

  test 'should create sponsor_image' do
    assert_difference('SponsorImage.count') do
      post sponsor_images_url,
           params: { sponsor_image: { file: image_file, sponsor_id: @sponsor_image.sponsor_id } },
           env: private_auth_header
    end

    assert_response 201
  end

  test 'should show sponsor_image' do
    get sponsor_image_url(@sponsor_image), env: public_auth_header
    assert_equal response.header['Content-Type'], 'image/png'
    assert_equal response.header['Content-Disposition'], 'attachment'
    assert_equal response.header['Content-Length'].to_i, image_file.size

    assert_response :success
  end

  test 'should update sponsor_image' do
    patch sponsor_image_url(@sponsor_image),
          params: { sponsor_image: { file: image_file, sponsor_id: @sponsor_image.sponsor_id } },
          env: private_auth_header
    assert_response 200
  end

  test 'should destroy sponsor_image' do
    assert_difference('SponsorImage.count', -1) do
      delete sponsor_image_url(@sponsor_image), env: private_auth_header
    end

    assert_response 204
  end

  class FlawedSponsorImagesControllerTest < ActionDispatch::IntegrationTest
    setup do
      @sponsor_image = create(:sponsor_image, sponsor: create(:sponsor))
      SponsorImage.any_instance.stubs(:save).returns(false)
    end

    test 'should NOT create sponsor image' do
      assert_no_difference('SponsorImage.count') do
        post sponsor_images_url, params: { sponsor_image: { sponsor_id: 'gach' } }, env: private_auth_header
      end

      assert_response 422
    end

    test 'should NOT update sponsor image' do
      patch sponsor_image_url(@sponsor_image), params: { sponsor_image: { sponsor_id: 'gach' } }, env: private_auth_header
      assert_response 422
    end
  end
end

require 'test_helper'

class SponsorImageTest < ActiveSupport::TestCase
  def image_file
    Rack::Test::UploadedFile.new('test/fixtures/files/logo.png', 'image/png')
  end

  test 'empty instatiation' do
    SponsorImage.new(sponsor: create(:sponsor))
  end

  test 'attaching a file' do
    image = SponsorImage.new(file: image_file, sponsor: create(:sponsor))

    assert_equal(image.content_type, 'image/png')
    assert_not_nil(image.file_contents)
  end

  test 'updating an attachment' do
    image = SponsorImage.new(file: nil, sponsor: create(:sponsor))
    image.update(file: image_file, sponsor: create(:sponsor))

    assert_equal(image.content_type, 'image/png')
    assert_not_nil(image.file_contents)
  end

  test 'raising' do
    assert_raises(StandardError, 'Security measure: not a file') do
      SponsorImage.new(file: 'fake', sponsor: create(:sponsor))
    end
  end
end

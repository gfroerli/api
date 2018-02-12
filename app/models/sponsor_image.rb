class SponsorImage < ApplicationRecord
  belongs_to :sponsor

  # Done like this: http://ryan.endacott.me/2014/06/10/rails-file-upload.html
  def initialize(params = {})
    file = params.delete(:file)
    super

    return unless file

    self.content_type = file.content_type
    self.file_contents = file.read
  end

  def update(attributes)
    file = attributes.delete(:file)

    return unless file

    self.content_type = file.content_type
    self.file_contents = file.read

    super(attributes)
  end
end

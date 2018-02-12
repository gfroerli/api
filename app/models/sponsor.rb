class Sponsor < ApplicationRecord
  has_many :sensors
  has_one :sponsor_image
end

class Sensor < ApplicationRecord
  has_many :measurements, dependent: :destroy
  belongs_to :sponsor, optional: true
  belongs_to :waterbody, optional: true

  validates :device_name, presence: true
  validates :shortname, length: { maximum: 4 }
  validates :caption, presence: true
  validates :latitude, presence: true
  validates :longitude, presence: true
end

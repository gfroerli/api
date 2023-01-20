class Sensor < ApplicationRecord
  has_many :measurements, dependent: :destroy
  belongs_to :sponsor, optional: true

  validates :device_name, presence: true
  validates :caption, presence: true
  validates :latitude, presence: true
  validates :longitude, presence: true
end

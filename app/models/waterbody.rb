class Waterbody < ApplicationRecord
  has_many :sensors, dependent: :nullify

  validates :name, :latitude, :longitude, presence: true
end

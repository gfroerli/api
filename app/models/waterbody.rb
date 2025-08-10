class Waterbody < ApplicationRecord
  has_many :sensors, dependent: :nullify

  validates :name, :description, :latitude, :longitude, presence: true
end

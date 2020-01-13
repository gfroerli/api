class Sponsor < ApplicationRecord
  has_many :sensors, dependent: :nullify
  has_one :sponsor_image, dependent: :nullify

  validates :name, presence: true
end

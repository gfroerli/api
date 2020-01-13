class Sponsor < ApplicationRecord
  has_many :sensors, dependent: :nullify
  has_one :sponsor_image

  validates :name, presence: true
end

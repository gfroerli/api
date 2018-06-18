class Sponsor < ApplicationRecord
  has_many :sensors, dependent: :nullify

  validates :name, presence: true
end

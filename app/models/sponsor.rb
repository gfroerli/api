class Sponsor < ApplicationRecord
  has_many :sensors, dependent: :nullify

  enum :sponsor_type, { sponsor: 'sponsor', public_data_provider: 'public_data_provider', partner: 'partner' }

  validates :name, presence: true
  validates :sponsor_type, presence: true
end

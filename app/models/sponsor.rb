class Sponsor < ApplicationRecord
  has_many :sensors, dependent: :nullify

  enum :sponsor_type, { sponsor: 'sponsor', public_data_provider: 'public_data_provider', partner: 'partner' },
       validate: true

  validates :name, presence: true
end

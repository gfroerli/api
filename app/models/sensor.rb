class Sensor < ApplicationRecord
  belongs_to :sponsor, optional: true
  has_many :measurements
end

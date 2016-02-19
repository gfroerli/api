class Sensor < ApplicationRecord
  belongs_to :sponsor
  has_many :measurements
end

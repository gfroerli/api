# frozen_string_literal: true
class ApiConsumer < ApplicationRecord
  validates :public_api_key, presence: true, uniqueness: true, length: { minimum: 16 }
  validates :contact_email, presence: true
end

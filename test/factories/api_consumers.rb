FactoryBot.define do
  factory :api_consumer do
    public_api_key { SecureRandom.hex }
    contact_email { 'admin@exampleapp.com' }

    factory :private_api_consumer do
      private_api_key { SecureRandom.hex }
    end
  end
end

FactoryBot.define do
  factory :measurement do
    temperature { '5.034445' }
    custom_attributes { { sample_reading: 'blub' } }
    sensor
  end
end

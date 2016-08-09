# frozen_string_literal: true
FactoryGirl.define do
  factory :sensor do
    device_name 'photon_device_nr4562'
    caption 'HSR Mark I'
    location { Hash[latitude: 47.222578, longitude: 8.814744] }
    sponsor
  end
end

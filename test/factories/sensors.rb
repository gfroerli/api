FactoryGirl.define do
  factory :sensor do
    device_name "MyString"
    caption "MyString"
    location { Hash[latitude: 47, longitude: 8] }
    sponsor
  end
end

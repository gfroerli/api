# frozen_string_literal: true
FactoryGirl.define do
  factory :measurement do
    temperature '5.034445'
    custom_attributes Hash[sample_reading: 'blub']
    sensor
  end
end

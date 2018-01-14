# frozen_string_literal: true

json.array!(@sensors) do |sensor|
  json.extract! sensor, :id, :device_name, :caption, :latitude, :longitude, :sponsor_id, :measurement_ids
  json.extract! sensor, :created_at, :updated_at
  json.last_measurement sensor.measurements.last
  json.url sensor_url(sensor, format: :json)
end

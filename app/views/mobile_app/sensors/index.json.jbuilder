json.array!(@sensors) do |sensor|
  json.extract! sensor, :id, :sponsor_id, :device_name, :shortname, :caption, :latitude, :longitude
  json.created_at sensor.created_at.to_i
  json.latest_temperature @latest_sensor_measurements.dig(sensor.id, :temperature)
  json.latest_measurement_at @latest_sensor_measurements.dig(sensor.id, :created_at)&.to_i
end

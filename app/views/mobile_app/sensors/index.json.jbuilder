json.array!(@sensors) do |sensor|
  json.extract! sensor, :id, :device_name, :caption, :latitude, :longitude
  json.created_at sensor.created_at.to_i
  json.latest_temperature @latest_sensor_measurements.include?(sensor.id) ? @latest_sensor_measurements[sensor.id][:temperature] : nil
  json.latest_measurement_at @latest_sensor_measurements.include?(sensor.id) ? @latest_sensor_measurements[sensor.id][:created_at] : nil
end

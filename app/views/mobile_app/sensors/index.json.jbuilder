json.array!(@sensors) do |sensor|
  json.extract! sensor, :id, :device_name, :caption, :latitude, :longitude
  json.created_at sensor.created_at.to_i
  json.latest_temperature @latest_sensor_temperatures[sensor.id]
  json.url sensor_url(sensor, format: :json)
end

json.array!(@sensors) do |sensor|
  json.extract! sensor, :id, :device_name, :caption, :latitude, :longitude
  json.extract! sensor, :created_at
  json.latest_temperature @latest_sensor_temperatures[sensor.id]
  json.url sensor_url(sensor, format: :json)
end

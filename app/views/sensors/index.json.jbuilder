json.array!(@sensors) do |sensor|
  json.extract! sensor, :id, :device_name, :caption, :location, :sponsor
  json.url sensor_url(sensor, format: :json)
end

json.array!(@sensors) do |sensor|
  json.extract! sensor, :id, :device_name, :caption, :location, :sponsor_id, :measurement_ids
  json.extract! sensor, :created_at, :updated_at
  json.url sensor_url(sensor, format: :json)
end

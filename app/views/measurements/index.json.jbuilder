json.array!(@measurements) do |measurement|
  json.extract! measurement, :id, :temperature, :custom_attributes, :sensor_id
  json.extract! measurement, :created_at, :updated_at
  json.url measurement_url(measurement, format: :json)
end

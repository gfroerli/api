json.array!(@sponsors) do |sponsor|
  json.extract! sponsor, :id, :name, :description, :active, :sensor_ids
  json.url sponsor_url(sponsor, format: :json)
end

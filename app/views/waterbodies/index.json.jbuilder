json.array!(@waterbodies) do |waterbody|
  json.extract! waterbody, :id, :name, :description, :latitude, :longitude, :sensor_ids
  json.url waterbody_url(waterbody, format: :json)
end

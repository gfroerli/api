json.array!(@sponsors) do |sponsor|
  json.extract! sponsor, :id, :name, :description, :active, :sensor_ids, :sponsor_image
  json.sponsor_image_id @sponsor&.sponsor_image&.id
  json.extract! sponsor, :created_at, :updated_at
  json.url sponsor_url(sponsor, format: :json)
end

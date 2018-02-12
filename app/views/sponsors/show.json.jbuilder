json.extract! @sponsor, :id, :name, :description, :active, :sensor_ids, :created_at, :updated_at
json.sponsor_image_id @sponsor&.sponsor_image&.id

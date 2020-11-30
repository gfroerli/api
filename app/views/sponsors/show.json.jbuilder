json.extract! @sponsor, :id, :name, :description, :active, :sensor_ids, :created_at, :updated_at
json.logo_url(@sponsor.logo_source.present? ? image_url(@sponsor.logo_source) : nil)

json.extract! @sponsor, :id, :name, :description, :created_at
json.logo_url(@sponsor.logo_source.present? ? image_url(@sponsor.logo_source) : nil)

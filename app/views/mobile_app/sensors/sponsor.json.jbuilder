json.extract! @sponsor, :id, :name, :description, :sponsor_type
json.logo_url(@sponsor.logo_source.present? ? image_url(@sponsor.logo_source, skip_pipeline: true) : nil)

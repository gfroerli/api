json.extract! @sponsor, :id, :name, :description, :created_at
json.logo_url image_url(@sponsor.logo_source || 'coredump.png')

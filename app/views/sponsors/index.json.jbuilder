json.array!(@sponsors) do |sponsor|
  json.extract! sponsor, :id, :name, :description, :active
  json.url sponsor_url(sponsor, format: :json)
end

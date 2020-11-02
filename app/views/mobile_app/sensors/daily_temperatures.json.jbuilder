json.array!(@aggregations) do |row|
  json.aggregation_date row.aggregation_date
  json.minimum_temperature row.minimum_temperature
  json.maximum_temperature row.maximum_temperature
  json.average_temperature row.average_temperature&.to_f
end

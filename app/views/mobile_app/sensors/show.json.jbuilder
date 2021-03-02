json.extract! @sensor, :id, :device_name, :caption, :latitude, :longitude, :sponsor_id
json.created_at @sensor.created_at.to_i
json.latest_temperature @latest_measurement&.temperature
json.latest_measurement_at @latest_measurement&.created_at&.to_i
json.extract! @sensor, :minimum_temperature, :maximum_temperature, :average_temperature

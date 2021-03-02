json.extract! @sensor, :id, :device_name, :caption, :latitude, :longitude, :sponsor_id
json.created_at @sensor.created_at.to_i
json.latest_temperature @latest_sensor_temperature
json.latest_measurement_at @latest_measurement_at&.to_time.to_i
json.extract! @sensor, :minimum_temperature, :maximum_temperature, :average_temperature

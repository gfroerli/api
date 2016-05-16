class DeviceReporter
  def initialize(device_name)
    @device_name = device_name
    @measurements = []
  end

  def report!(event_json)
    measurement = parse_measurement(event_json.data)
    sensor = Sensor.find_or_create_by(device_name: @device_name)
    sensor.measurements << measurement
    sensor.save!
  end

  private

  def parse_measurement(csv_data)
    raw_hash = Hash[csv_data.split(',').map { |kv| kv.split('=') }.flatten]
    Measurement.new temperature: raw_hash[:t1],
                    custom_attributes: {
                        voltage: raw_hash[:v],
                        capacity: raw_hash[:c]
                    }
  end
end

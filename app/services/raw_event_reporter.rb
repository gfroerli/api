class RawEventReporter
  def report!(event)
    measurement = parse_measurement(event.data)
    sensor = Sensor.find_or_create_by(device_name: event.coreid)
    sensor.measurements << measurement
    sensor.save!
  end

  private

  def parse_measurement(csv_data)
    raw_hash = {}
    csv_data.split(',').each do |kv|
      k, v = kv.split('=')
      raw_hash[k.to_sym] = v
    end

    Measurement.new temperature: raw_hash[:t1],
                    custom_attributes: {
                      voltage: raw_hash[:v],
                      capacity: raw_hash[:c]
                    }
  end
end

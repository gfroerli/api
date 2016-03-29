class DeviceReporter
  def initialize(device_name, initial_data = [])
    @device_name = device_name
    @measurements = []
    initial_data.each(&method(:add_data))
  end

  def add_data(hash)
    @measurements << Measurement.new(temperature: hash[:temperature],
                                     custom_attributes: hash.except(:temperature))
  end

  def submit!
    sensor = Sensor.find_or_create_by(device_name: @device_name)
    sensor.measurements << @measurements
    sensor.save!
  end
end

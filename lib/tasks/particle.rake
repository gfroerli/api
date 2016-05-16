namespace :particle do
  desc 'update sensor status and data'
  task update: :environment do
    uri = URI("https://api.particle.io/v1/devices/events/?access_token=#{ENV['PARTICLE_ACCESS_TOKEN']}")

    parser = EventStreamParse.new 'measurement' do |data_json|
      DeviceReporter.new(data_json.coreid).report!(data_json)
    end

    Net::HTTP.start(uri.host, uri.port, use_ssl: uri.scheme == 'https') do |http|
      request = Net::HTTP::Get.new(uri)

      http.request(request) do |response|
        response.value
        response.read_body { |chunk| parser.feed(chunk) }
      end
    end

    ## if load gets high, we can bulk save:
    #reporters = client.devices.map do |device|
    #  DeviceReporter.new(device.name, [{ temperature: device.get('temperature') }])
    #end
    #reporters.each(&:submit!)
  end
end
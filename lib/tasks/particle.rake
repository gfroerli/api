namespace :particle do
  desc 'update sensor status and data'
  task update: :environment do
    uri = URI("https://api.particle.io/v1/devices/events/?access_token=#{ENV['PARTICLE_ACCESS_TOKEN']}")

    def parse_event(buffer)
      regexp = %r{
        event:\s.temperature
        \s
        data:\s(\{.*\})
      }x

      match = regexp.match(buffer)
      return nil unless match
      OpenStruct.new JSON.parse(match[1])
    end

    def handle_temperature_event(event)
      DeviceReporter.new(event.coreid, [{ temperature: event.data }]).submit!
    end

    Net::HTTP.start(uri.host, uri.port, use_ssl: uri.scheme == 'https') do |http|
      request = Net::HTTP::Get.new(uri)
      buffer = ''

      http.request(request) do |response|
        response.read_body do |chunk|
          if chunk.blank?
            event = parse_event(buffer)
            handle_temperature_event(event) if event
            buffer.clear
          else
            buffer << chunk
          end
        end
      end
    end

    ## if load gets high, we can bulk save:
    #reporters = client.devices.map do |device|
    #  DeviceReporter.new(device.name, [{ temperature: device.get('temperature') }])
    #end
    #reporters.each(&:submit!)
  end
end
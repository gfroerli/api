namespace :particle do
  desc 'update sensor status and data'
  task update: :environment do
    require 'particle'

    client = Particle::Client.new(access_token: ENV['PARTICLE_ACCESS_TOKEN'])

    reporters = client.devices.map do |device|
      DeviceReporter.new(device.name, [{ temperature: device.get('temperature') }])
    end

    reporters.each(&:submit!)
  end
end
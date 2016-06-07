namespace :particle do
  desc 'update sensor status and data'
  task update: :environment do
    uri = URI("https://api.particle.io/v1/devices/events/?access_token=#{ENV['PARTICLE_ACCESS_TOKEN']}")

    reporter = RawEventReporter.new
    parser = EventStreamParser.new('measurement') do |event|
      reporter.report!(event)
    end

    Net::HTTP.start(uri.host, uri.port, use_ssl: uri.scheme == 'https') do |http|
      request = Net::HTTP::Get.new(uri)

      http.request(request) do |response|
        response.value
        response.read_body { |chunk| parser.feed(chunk) }
      end
    end
  end
end
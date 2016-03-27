seeds = [
          {
              name: 'Hochschule für Technik Rapperswil',
              description: 'Die HSR ist tätig in den Bereichen Technik und Informationstechnologie.',
              sensor_prefix: 'HSR Mark '
          },
          {
              name: 'Badi Lachen',
              description: 'Wunderbar und an einzigartiger Lage am oberen Zürichsee gelegen.',
              sensor_prefix: 'Boje T'
          },
          {
              name: 'Hotel Schwanen',
              description: 'The Hotel Schwanen in Rapperswil has a proud tradition.',
              sensor_prefix: 'Swan '
          },
          {
              name: 'Seebad Enge',
              description: 'Das Seebad Enge wird seit Frühjahr 1999 von der Tonttu GmbH privat betrieben. ',
              sensor_prefix: 'Badi '
          },
          {
              name: 'Strandbad Küsnacht',
              description: 'Seebad mit ca. 30 m Sandstrand am Zürichsee',
              sensor_prefix: 'Goldküste Sensor '
          },
      ]

seeds.each_with_index do |seed, i|
  sponsor = Sponsor.create! name: seed[:name],
                            description: seed[:description],
                            active: true

  sensor = Sensor.create! device_name: "photon_device_#{i}",
                          caption: "#{seed[:sensor_prefix]}#{i}",
                          location: { latitude: 47+(i/100), longitude: 8+(i/100) },
                          sponsor: sponsor

  50.times do
    Measurement.create! temperature: rand(3000)/100, custom_attributes: Hash[sample_reading: '5.645V'], sensor: sensor
  end
end

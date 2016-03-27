sponsor = Sponsor.create! name: 'Hochschule für Technik Rapperswil',
                          description: 'Die HSR ist tätig in den beiden Bereichen Technik und Informationstechnologie sowie Architektur, Bau- und Planungswesen.',
                          active: true

sensor = Sensor.create! device_name: 'photon_device_45',
                        caption: 'HSR Mark I',
                        location: { latitude: 47.222578, longitude: 8.814744 },
                        sponsor: sponsor

Measurement.create! [{temperature: 5.45682, custom_attributes: Hash[sample_reading: '5.645V'], sensor: sensor},
                     {temperature: 6.45443, custom_attributes: Hash[sample_reading: '5.634V'], sensor: sensor},
                     {temperature: 5.23145, custom_attributes: Hash[sample_reading: '5.622V'], sensor: sensor},
                     {temperature: 3.43474, custom_attributes: Hash[sample_reading: '5.632V'], sensor: sensor},
                     {temperature: 3.56567, custom_attributes: Hash[sample_reading: '5.644V'], sensor: sensor},
                     {temperature: 3.56567, custom_attributes: Hash[sample_reading: '5.612V'], sensor: sensor},
                     {temperature: 3.89346, custom_attributes: Hash[sample_reading: '5.611V'], sensor: sensor},
                     {temperature: 4.45565, custom_attributes: Hash[sample_reading: '5.617V'], sensor: sensor},
                     {temperature: 4.65767, custom_attributes: Hash[sample_reading: '5.676V'], sensor: sensor}]

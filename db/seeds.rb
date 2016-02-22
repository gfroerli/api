sponsor = Sponsor.create! name: 'Hochschule für Technik Rapperswil',
                          description: 'Die HSR ist tätig in den beiden Bereichen Technik und Informationstechnologie sowie Architektur, Bau- und Planungswesen.',
                          active: true

sensor = Sensor.create! device_name: 'photon_device_45',
                        caption: 'HSR Mark I',
                        location: { latitude: 47.222578, longitude: 8.814744 },
                        sponsor: sponsor

_measurement = Measurement.create! temperature: 5.45682,
                                   custom_attributes: Hash[sample_reading: '5.645V'],
                                   sensor: sensor

class Measurement < ApplicationRecord
  belongs_to :sensor

  validates :temperature, numericality: true

  def self.last_per_sensor(count)
    subquery = Measurement.select('*, ROW_NUMBER() OVER (PARTITION BY sensor_id ORDER BY created_at DESC) row_number')
    from(Arel.sql("(#{subquery.to_sql}) as measurements")).where('row_number <= ?', count)
  end
end

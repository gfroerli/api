class Measurement < ApplicationRecord
  belongs_to :sensor

  attribute :override_created_at

  validates :temperature, numericality: true
  validate :override_created_at_within_1_hour, if: :override_created_at?

  before_save :apply_override_created_at

  # TODO: rename to latest_per_sensor
  def self.last_per_sensor(count)
    subquery = Measurement.select('*, ROW_NUMBER() OVER (PARTITION BY sensor_id ORDER BY created_at DESC) row_number')
    from(Arel.sql("(#{subquery.to_sql}) as measurements")).where(row_number: ..count)
  end

  private

  def apply_override_created_at
    return if override_created_at.nil?

    self.created_at = override_created_at
  end

  def override_created_at_within_1_hour
    self.override_created_at = Time.zone.parse(override_created_at)

    unless override_created_at&.between?(60.minutes.ago, 3.minutes.from_now)
      errors.add :override_created_at, 'Must be within the last 60 minutes.'
    end
  end
end

class MakeLatitudeAndLongitudeNonNullableForSensors < ActiveRecord::Migration[6.0]
  def change
    change_column_null :sensors, :latitude, false
    change_column_null :sensors, :longitude, false
  end
end

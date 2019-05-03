class UpdateNullConstraints < ActiveRecord::Migration[5.2]
  def change
    change_column_null :sensors, :caption, false
    change_column_null :sensors, :device_name, false

    change_column_default :sponsors, :active, true
    change_column_null :sponsors, :active, false
    change_column_null :sponsors, :name, false

    change_column_null :measurements, :temperature, false
    change_column_null :measurements, :sensor_id, false
  end
end

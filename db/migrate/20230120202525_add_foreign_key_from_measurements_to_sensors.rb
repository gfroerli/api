class AddForeignKeyFromMeasurementsToSensors < ActiveRecord::Migration[6.0]
  def change
    add_foreign_key :measurements, :sensors
  end
end

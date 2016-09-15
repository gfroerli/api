class ChangeLocationFromSensors < ActiveRecord::Migration[5.0]
  def change
    remove_column :sensors, :location, :json
    add_column :sensors, :latitude, :float
    add_column :sensors, :longitude, :float
  end
end

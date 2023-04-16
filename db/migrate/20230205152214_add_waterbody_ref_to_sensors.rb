class AddWaterbodyRefToSensors < ActiveRecord::Migration[6.1]
  def change
    add_reference :sensors, :waterbody, foreign_key: true
  end
end

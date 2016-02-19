class CreateSensors < ActiveRecord::Migration[5.0]
  def change
    create_table :sensors do |t|
      t.string :device_name
      t.string :caption
      t.json :location
      t.belongs_to :sponsor

      t.timestamps
    end
  end
end

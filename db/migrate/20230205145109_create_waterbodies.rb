class CreateWaterbodies < ActiveRecord::Migration[6.1]
  def change
    create_table :waterbodies do |t|
      t.string :name, null: false
      t.string :description, null: false
      t.float :latitude, null: false
      t.float :longitude, null: false

      t.timestamps
    end
  end
end

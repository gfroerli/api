class CreateSponsors < ActiveRecord::Migration[5.0]
  def change
    create_table :sponsors do |t|
      t.string :name
      t.text :description
      t.boolean :active

      t.timestamps
    end
  end
end

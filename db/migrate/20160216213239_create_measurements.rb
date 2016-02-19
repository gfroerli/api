class CreateMeasurements < ActiveRecord::Migration[5.0]
  def change
    create_table :measurements do |t|
      t.decimal :temperature
      t.json :custom_attributes
      t.belongs_to :sensor

      t.timestamps
    end
  end
end

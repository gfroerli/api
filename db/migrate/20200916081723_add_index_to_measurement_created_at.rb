class AddIndexToMeasurementCreatedAt < ActiveRecord::Migration[5.2]
  def change
    add_index :measurements, :created_at
  end
end

class ConvertDecimalToFloat < ActiveRecord::Migration[5.2]
  def change
    change_column :measurements, :temperature, :float
  end
end

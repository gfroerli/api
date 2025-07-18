class AddShortnameToSensor < ActiveRecord::Migration[7.2]
  def change
    add_column :sensors, :shortname, :string, limit: 4
  end
end

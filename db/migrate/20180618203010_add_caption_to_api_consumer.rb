class AddCaptionToApiConsumer < ActiveRecord::Migration[5.2]
  def change
    add_column :api_consumers, :caption, :string
  end
end

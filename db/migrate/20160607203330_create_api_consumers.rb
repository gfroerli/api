class CreateApiConsumers < ActiveRecord::Migration[5.0]
  def change
    create_table :api_consumers do |t|
      t.string :public_api_key
      t.string :private_api_key
      t.string :contact_email

      t.timestamps
    end
  end
end

class AddUniqueIndexToApiConsumerPublicApiKey < ActiveRecord::Migration[7.2]
  def change
    add_index :api_consumers, :public_api_key, unique: true
  end
end

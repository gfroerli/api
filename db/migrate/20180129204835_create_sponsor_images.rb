class CreateSponsorImages < ActiveRecord::Migration[5.1]
  def change
    create_table :sponsor_images do |t|
      t.references :sponsor, foreign_key: true
      t.string :content_type
      t.binary :file_contents

      t.timestamps
    end
  end
end

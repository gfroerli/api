class AddImageToSponsor < ActiveRecord::Migration[6.0]
  def change
    add_column :sponsors, :logo_source, :string, null: true
    change_column_comment(:sponsors, :logo_source,
                          from: '', to: 'filename (in ./public/images/), relative path or URL')
  end
end

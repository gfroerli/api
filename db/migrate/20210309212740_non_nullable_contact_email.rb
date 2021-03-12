class NonNullableContactEmail < ActiveRecord::Migration[6.0]
  def change
    change_column_null :api_consumers, :contact_email, false, 'vorstand@lists.coredump.ch'
  end
end

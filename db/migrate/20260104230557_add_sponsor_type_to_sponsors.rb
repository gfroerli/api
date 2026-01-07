class AddSponsorTypeToSponsors < ActiveRecord::Migration[8.1]
  def change
    add_column :sponsors, :sponsor_type, :string, default: 'sponsor', null: false
  end
end

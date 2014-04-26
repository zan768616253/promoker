class AddProfilableToProfiles < ActiveRecord::Migration
  def change
    add_column :profiles, :profilable_id, :string
    add_column :profiles, :profilable_type, :string
    add_index :profiles, :profilable_id
  end
end

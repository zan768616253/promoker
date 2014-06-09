class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.string  :nickname
      t.string  :gender
      t.string  :about
      t.string  :province
      t.string  :city
      t.string  :district
      t.string  :location
      t.string  :name
      t.string  :role
      t.string  :about
      t.string  :style
      t.string  :avatar
      t.integer :profilable_id
      t.string  :profilable_type
      t.timestamps
    end
    add_index :profiles, :profilable_id
  end
end

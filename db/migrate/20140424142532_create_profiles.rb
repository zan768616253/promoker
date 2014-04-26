class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.string :name
      t.string :role
      t.string :about
      t.string :style
      t.string :avatar
      t.timestamps
    end
  end
end

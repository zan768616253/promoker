class CreateActors < ActiveRecord::Migration
  def change
    create_table :actors do |t|
	  t.string :name 
	  t.string :about
	  t.string :location
	  t.string :avatar
	  t.string :style
      t.timestamps
    end
  end
end

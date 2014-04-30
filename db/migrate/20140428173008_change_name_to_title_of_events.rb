class ChangeNameToTitleOfEvents < ActiveRecord::Migration
  def change
  	remove_column :events, :name 
  	add_column :events, :title, :string
  end
end

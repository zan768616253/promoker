class ChangeNameToTitleOfProjects < ActiveRecord::Migration
  def change
  	remove_column :projects, :name
  	add_column :projects, :title, :string, :default => 'untitled'
  end
end

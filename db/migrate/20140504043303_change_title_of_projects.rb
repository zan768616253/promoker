class ChangeTitleOfProjects < ActiveRecord::Migration
  def change
  	change_column :projects, :title, :string, :default => 'untitled'
  end
end

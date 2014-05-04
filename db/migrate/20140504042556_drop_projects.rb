class DropProjects < ActiveRecord::Migration
  def change
  	drop_table :projects
  	rename_table :project_details, :projects
  end
end

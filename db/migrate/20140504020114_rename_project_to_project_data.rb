class RenameProjectToProjectData < ActiveRecord::Migration
  def change
  	rename_table :projects, :project_details
  end
end

class ChangeReferenceOfProjectDetails < ActiveRecord::Migration
  def change
  	remove_reference :projects, :user
  	add_reference :project_details, :project
  end
end

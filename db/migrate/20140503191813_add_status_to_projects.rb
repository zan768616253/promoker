class AddStatusToProjects < ActiveRecord::Migration
  def change
  	add_column :projects, :status, :string, :default => 'draft'
  end
end

class AddStartAtToProjects < ActiveRecord::Migration
  def change
  	add_column :projects, :start_at, :datetime
  end
end

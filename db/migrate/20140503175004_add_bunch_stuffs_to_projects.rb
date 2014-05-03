class AddBunchStuffsToProjects < ActiveRecord::Migration
  def change
  	add_column :projects, :type, :string
  	add_column :projects, :duration, :string
  	add_column :projects, :budget, :string
  	add_column :projects, :description, :text
  	add_column :projects, :script, :text
  	add_column :projects, :team, :text
  	add_column :projects, :plan, :text
  	add_column :projects, :expense, :text
  	add_column :projects, :cover, :string
  	add_column :projects, :video, :string
  end
end

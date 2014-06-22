class AddHomePageHomePageOrderToProjects < ActiveRecord::Migration
  def change
  	add_column :projects, :home_page, :boolean, :default => false
  	add_column :projects, :home_page_order, :integer, :default => 0
  end
end

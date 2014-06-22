class AddHomePageHomePageOrderToEvents < ActiveRecord::Migration
  def change
  	add_column :events, :home_page, :boolean, :default => false
  	add_column :events, :home_page_order, :integer, :default => 0
  end
end

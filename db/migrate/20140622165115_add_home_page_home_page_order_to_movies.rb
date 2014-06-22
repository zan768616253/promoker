class AddHomePageHomePageOrderToMovies < ActiveRecord::Migration
  def change
  	add_column :movies, :home_page, :boolean, :default => false
  	add_column :movies, :home_page_order, :integer, :default => 0
  end
end

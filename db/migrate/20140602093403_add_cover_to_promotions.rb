class AddCoverToPromotions < ActiveRecord::Migration
  def change
  	add_column :promotions, :cover, :string
  end
end

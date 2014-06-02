class AddStateToPromotions < ActiveRecord::Migration
  def change
  	add_column :promotions, :state, :string, :default => "draft"
  end
end

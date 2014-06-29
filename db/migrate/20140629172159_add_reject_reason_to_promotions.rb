class AddRejectReasonToPromotions < ActiveRecord::Migration
  def change
  	add_column :promotions, :reject_reason, :string
  end
end

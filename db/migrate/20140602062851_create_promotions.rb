class CreatePromotions < ActiveRecord::Migration
  def change
    create_table :promotions do |t|
      t.string :title, :default => "untitled"
      t.string :file
      t.timestamps
    end
  end
end

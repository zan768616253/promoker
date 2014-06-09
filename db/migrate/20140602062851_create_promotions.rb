class CreatePromotions < ActiveRecord::Migration
  def change
    create_table :promotions do |t|
      t.string   :title,      default: "untitled"
	  t.string   :file
	  t.datetime :created_at
	  t.datetime :updated_at
	  t.references  :user
	  t.string   :state,      default: "draft"
	  t.string   :cover
      t.timestamps
    end
  end
end

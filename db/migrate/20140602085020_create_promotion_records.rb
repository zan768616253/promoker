class CreatePromotionRecords < ActiveRecord::Migration
  def change
    create_table :promotion_records do |t|
      t.datetime :promote_time
	  t.string :channel       
	  t.string :desc
	  t.string :screenshot
	  t.string :url
      t.references :promotion
      t.timestamps
    end
  end
end

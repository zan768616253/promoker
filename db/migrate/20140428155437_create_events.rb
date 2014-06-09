class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string   :thumb
      t.string   :address
      t.text     :content
      t.datetime :start_time
      t.datetime :end_time
      t.string   :title
      t.text     :summary
      t.string   :status
      t.timestamps
    end
  end
end

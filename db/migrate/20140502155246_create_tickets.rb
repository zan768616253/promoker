class CreateTickets < ActiveRecord::Migration
  def change
    create_table :tickets do |t|
      t.string :title
      t.string :province
      t.string :city
      t.string :district
      t.string :location
      t.string :contact
      t.timestamps
    end
  end
end

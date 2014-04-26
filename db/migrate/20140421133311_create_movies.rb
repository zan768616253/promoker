class CreateMovies < ActiveRecord::Migration
  def change
    create_table :movies do |t|
      t.string :title
      t.text :desc
      t.string :short_desc
      t.string :thumb
      t.string :director
      t.string :duration
      t.timestamps
    end
  end
end

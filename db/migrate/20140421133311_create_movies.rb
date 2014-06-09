class CreateMovies < ActiveRecord::Migration
  def change
    create_table :movies do |t|
      t.string :title
      t.text   :desc
      t.string :short_desc
      t.string :thumb
      t.string :duration
      t.string :url
      t.text   :summary
      t.references :director
      t.references :user
      t.timestamps
    end
  end
end

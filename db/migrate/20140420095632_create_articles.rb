class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :title
      t.text :body
      t.string :author
      t.string :thumb
      t.timestamps
    end
  end
end

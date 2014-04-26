class AddContentToMovies < ActiveRecord::Migration
  def change
  	add_column :movies, :content, :text
  end
end

class RemoveContentFromMovies < ActiveRecord::Migration
  def change
  	remove_column :movies, :content
  end
end

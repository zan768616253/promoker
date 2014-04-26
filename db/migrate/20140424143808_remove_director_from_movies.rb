class RemoveDirectorFromMovies < ActiveRecord::Migration
  def change
    remove_column :movies, :director
  end
end

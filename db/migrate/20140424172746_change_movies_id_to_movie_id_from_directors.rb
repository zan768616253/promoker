class ChangeMoviesIdToMovieIdFromDirectors < ActiveRecord::Migration
  def change
    remove_column :directors_movies, :movies_id
    remove_column :directors_movies, :directors_id
    add_column :directors_movies, :director_id, :integer
  end
end

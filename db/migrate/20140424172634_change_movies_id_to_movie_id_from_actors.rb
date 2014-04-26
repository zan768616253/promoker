class ChangeMoviesIdToMovieIdFromActors < ActiveRecord::Migration
  def change
    remove_column :actors_movies, :actors_id
    remove_column :actors_movies, :movies_id
    add_column :actors_movies, :actor_id, :integer
  end
end

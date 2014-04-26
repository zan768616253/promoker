class RemoveMovieIdFromActorsAndDirectors < ActiveRecord::Migration
  def change
    remove_column :directors, :movie_id
    remove_column :actors, :movie_id
  end
end

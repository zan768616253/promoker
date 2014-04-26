class AddMovieIdToActors < ActiveRecord::Migration
  def change
    add_column :actors, :movie_id, :integer
    add_index :actors, :movie_id
  end
end

class AddMovieIdToDirectors < ActiveRecord::Migration
  def change
    add_column :directors, :movie_id, :integer
    add_index :directors, :movie_id
  end
end

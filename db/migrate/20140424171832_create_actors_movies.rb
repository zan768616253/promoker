class CreateActorsMovies < ActiveRecord::Migration
  def change
    create_table :actors_movies do |t|
      t.belongs_to :movies
      t.belongs_to :actors
    end
  end
end

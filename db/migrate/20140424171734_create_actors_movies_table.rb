class CreateActorsMoviesTable < ActiveRecord::Migration
  def change
    create_table :actors_movies_tables do |t|
      t.belongs_to :movies
      t.belongs_to :actors
    end
  end
end

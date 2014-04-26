class CreateMoviesActorsTable < ActiveRecord::Migration
  def change
    create_table :movies_actors_tables do |t|
      t.belongs_to :movies
      t.belongs_to :actors
    end
  end
end

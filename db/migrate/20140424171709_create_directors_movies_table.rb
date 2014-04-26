class CreateDirectorsMoviesTable < ActiveRecord::Migration
  def change
    create_table :directors_movies_tables do |t|
      t.belongs_to :movies
      t.belongs_to :directors
    end
  end
end

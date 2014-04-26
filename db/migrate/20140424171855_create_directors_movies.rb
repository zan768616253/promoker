class CreateDirectorsMovies < ActiveRecord::Migration
  def change
    create_table :directors_movies do |t|
      t.belongs_to :movies
      t.belongs_to :directors
    end
  end
end

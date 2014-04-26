class CreateMoviesDirectorsTable < ActiveRecord::Migration
  def change
    create_table :movies_directors_tables do |t|
      t.belongs_to :movies
      t.belongs_to :directors
    end
  end
end

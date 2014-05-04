class ChangeTypeToMovieTypeOfProjects < ActiveRecord::Migration
  def change
  	remove_column :projects, :type
  	add_column :projects, :movie_type, :string
  end
end

class AddSummaryToMovies < ActiveRecord::Migration
  def change
  	add_column :movies, :summary, :text
  end
end

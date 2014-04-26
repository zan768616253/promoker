class AddNameToDirectors < ActiveRecord::Migration
  def change
    add_column :directors, :name, :string
  end
end

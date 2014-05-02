class AddSetToTags < ActiveRecord::Migration
  def change
  	add_column :tags, :set, :string, :default => 'default'
  end
end

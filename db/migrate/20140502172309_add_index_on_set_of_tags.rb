class AddIndexOnSetOfTags < ActiveRecord::Migration
  def change
  	add_index :tags, :set
  end
end

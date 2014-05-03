class ChangeContextOfTags < ActiveRecord::Migration
  def change
  	change_column :tags, :context, :string, :default => 'default'
  	remove_index :tags, :context
  end
end

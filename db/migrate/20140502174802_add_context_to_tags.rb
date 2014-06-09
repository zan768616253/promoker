class AddContextToTags < ActiveRecord::Migration
  def change
  	add_column :tags, :context, :string, :default => 'default'
  	add_index  :tags, :context
  end
end

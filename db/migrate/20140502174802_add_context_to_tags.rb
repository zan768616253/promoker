class AddContextToTags < ActiveRecord::Migration
  def change
  	add_column :tags, :context, :string
  	add_index  :tags, :context
  end
end

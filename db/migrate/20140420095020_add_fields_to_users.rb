class AddFieldsToUsers < ActiveRecord::Migration
	def change
		add_column :users, :name, :string
		add_column :users, :nickname, :string
		add_column :users, :gender, :string
		add_column :users, :about, :string
		add_column :users, :province, :string
		add_column :users, :city, :string
		add_column :users, :district, :string
		add_column :users, :location, :string
		add_column :users, :avatar, :string
	end
end
class AddNicknameAvatarGenderAboutToUsers < ActiveRecord::Migration
  def change
    add_column :users, :nickname, :string
    add_column :users, :avatar, :string
    add_column :users, :gender, :string
    add_column :users, :about, :string
  end
end

class Profile < ActiveRecord::Base
  belongs_to :profilable, :polymorphic => true
  mount_uploader :avatar, ImageUploader
end

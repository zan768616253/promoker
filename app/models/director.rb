class Director < ActiveRecord::Base
  has_many :movies
  mount_uploader :avatar, PhotoUploader
end

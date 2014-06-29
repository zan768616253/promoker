require 'file_size_validator' 
class Actor < ActiveRecord::Base
  has_and_belongs_to_many :movies
  mount_uploader :avatar, PhotoUploader
  validates :avatar, :presence => true,  :file_size => { :maximum => 0.5.megabytes.to_i } 
end

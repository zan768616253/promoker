require 'file_size_validator' 
class Photo < ActiveRecord::Base
	mount_uploader :image, PhotoUploader
	validates :image, :presence => true,  :file_size => { :maximum => 0.5.megabytes.to_i } 
end

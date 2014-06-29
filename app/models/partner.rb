require 'file_size_validator' 
class Partner < ActiveRecord::Base
	mount_uploader :thumb, PhotoUploader
	validates :thumb, :presence => true,  :file_size => { :maximum => 0.5.megabytes.to_i } 
end

require 'file_size_validator' 
class Promotion < ActiveRecord::Base
	belongs_to :user
	mount_uploader :cover, PhotoUploader
	mount_uploader :file, FileUploader
	has_many :promotion_records, :dependent => :destroy
	def state_enum
		['draft', 'received', 'promoting', 'complete']
	end

	validates :file,  :file_size => { :maximum => 0.3.megabytes.to_i } 
end

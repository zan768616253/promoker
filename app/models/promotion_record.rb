require 'file_size_validator' 
class PromotionRecord < ActiveRecord::Base
	belongs_to :promotion
	mount_uploader :screenshot, PhotoUploader
		validates :screenshot, :presence => true,  :file_size => { :maximum => 0.5.megabytes.to_i } 
end

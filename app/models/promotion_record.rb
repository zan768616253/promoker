class PromotionRecord < ActiveRecord::Base
	belongs_to :promotion
	mount_uploader :screenshot, ImageUploader
end

class Promotion < ActiveRecord::Base
	belongs_to :user
	mount_uploader :cover, ImageUploader
	mount_uploader :file, FileUploader
	has_many :promotion_records, :dependent => :destroy
end
class Partner < ActiveRecord::Base
	mount_uploader :thumb, ImageUploader
end

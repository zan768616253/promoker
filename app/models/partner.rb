class Partner < ActiveRecord::Base
	mount_uploader :thumb, PhotoUploader
end

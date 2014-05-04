class Project < ActiveRecord::Base
	acts_as_taggable_on :needs
	mount_uploader :cover, ImageUploader
	# scope :recent, -> { where(status: 'published').order('updated_at desc') }
	scope :recent, -> { order('updated_at desc') }
	belongs_to :user
end

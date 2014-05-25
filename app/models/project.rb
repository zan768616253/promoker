class Project < ActiveRecord::Base
	acts_as_taggable_on :needs
	mount_uploader :cover, ImageUploader
	scope :published,  -> { where(status: 'published') }
	scope :recent, -> { order('updated_at desc') }
	belongs_to :user

	def publish!
		self.status = 'published'
	end
	def unpublish!
		self.status = 'draft'
	end
end

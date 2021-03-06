require 'file_size_validator' 
class Project < ActiveRecord::Base
	include Bootsy::Container
	paginates_per 12
	acts_as_taggable_on :needs
	mount_uploader :cover, PhotoUploader
	validates :cover, :file_size => { :maximum => 0.5.megabytes.to_i } 
	scope :published,  -> { where(status: 'published') }
	scope :recent, -> { order('updated_at desc') }
	belongs_to :user


	def published?
		self.status == 'published'
	end
	def publish!
		self.status = 'published'
		self.published_at = Time.now
	end
	def unpublish!
		self.status = 'draft'
	end
end

class Event < ActiveRecord::Base
	acts_as_taggable_on :types, :tags, :locations
	acts_as_votable
	acts_as_commentable

	mount_uploader :thumb, ImageUploader
	scope :recent, -> { order("created_at DESC")}
	
end

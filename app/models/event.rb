class Event < ActiveRecord::Base
	paginates_per 5
	acts_as_taggable_on :types, :tags, :locations
	acts_as_votable
	acts_as_commentable

	mount_uploader :thumb, PhotoUploader
	scope :recent, -> { order("created_at DESC")}

	def started?
    	start_time.past?
  	end

  	def finished?
    	!end_time.nil? && Time.now.utc > end_time.utc
  	end
	
end

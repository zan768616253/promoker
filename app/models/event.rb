# coding: utf-8
class Event < ActiveRecord::Base
	paginates_per 5
	acts_as_taggable_on :types, :tags, :locations
	acts_as_votable
	acts_as_commentable

	mount_uploader :thumb, PhotoUploader
	scope :recent, -> { order("created_at DESC")}

	def status_enum
    	['upcoming', 'ongoing', 'finished']
  	end

	def type_enum
		Tag.tags_on(:event_type)
	end

	def location_enum
		Tag.tags_on(:location)
	end

	def started?
    	start_time.past?
  	end

  	def finished?
    	!end_time.nil? && Time.now.utc > end_time.utc
  	end
	
end

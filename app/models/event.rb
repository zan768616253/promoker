# coding: utf-8
require 'file_size_validator' 
class Event < ActiveRecord::Base
	paginates_per 5
	acts_as_taggable_on :types, :tags, :locations
	acts_as_votable
	acts_as_commentable

	mount_uploader :thumb, PhotoUploader
	validates :thumb, :presence => true,  :file_size => { :maximum => 0.5.megabytes.to_i } 
	scope :recent, -> { order("created_at DESC")}
	scope :selections, -> { tagged_with(I18n.t('event.type.filmfest')).where(:home_page => true).limit(3).order(home_page_order: :asc) }

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

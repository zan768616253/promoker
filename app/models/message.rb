# coding: utf-8
class Message < ActiveRecord::Base
	paginates_per 20
	belongs_to :from, :class_name => 'User'
	belongs_to :to, :class_name => 'User'

	scope :recent, ->(user) { where("to_id = ?", user.id).order('created_at DESC') }
	scope :unread, ->(user) { where("to_id = ? AND is_read = ?", user.id, false) }

	after_create :realtime_push_to_client

	def notify_hash
	    return "" if self.content.blank?
	    { 
	      :title => "你有一条新消息:", 
	      :content => self.content[0,30],
	      :content_path => self.content_path
	    } 
  	end

  	def content_path
    	"/messages/"+self.id.to_s
  	end
  
	def realtime_push_to_client
		if self.to
		  hash = self.notify_hash
		  hash[:avatar] = self.from.avatar
		  hash[:count] = Message.unread(self.to).count
		  FayeClient.send("/messages_count/#{self.to.temp_access_token}", hash)
		end
	end
end

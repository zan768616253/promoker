class Message < ActiveRecord::Base
	belongs_to :from, :class_name => 'User'
	belongs_to :to, :class_name => 'User'

	scope :recent, ->(user) { where("to_id = ?", user.id).order('created_at DESC') }
	scope :unread, ->(user) { where("to_id = ? AND read = ?", user.id, false) }
end

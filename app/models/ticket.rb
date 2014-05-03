class Ticket < ActiveRecord::Base
	acts_as_taggable_on :needs
	scope :recent, -> { order('updated_at desc') }
	belongs_to :user

	validates_presence_of :title, :user
	
end

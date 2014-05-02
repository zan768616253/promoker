class Ticket < ActiveRecord::Base
	acts_as_taggable_on :needs
	scope :recent, -> { order('updated_at desc') }
end

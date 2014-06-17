class Tag < ActsAsTaggableOn::Tag
	# has_many :taggings, :dependent => :destroy
	def validates_name_uniqueness?
		false
	end
	def self.tags_on(context, options = {})
		self.where(options.merge({:context => context.to_s})).pluck(:name)
	end
end
class HomeController < ApplicationController
	def index
		@recommends = Movie.all.limit(4)
		siteConfigs = SiteConfig.all
		@siteConfig = {}
		for config in siteConfigs
			p config
			@siteConfig[config.property] = config.value
		end
	end
end
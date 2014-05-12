# coding: utf-8
class HomeController < ApplicationController
	def index
		@projects = Project.published.recent.limit(4)
		@articles = Article.recent.limit(10)
		@events = Event.recent.limit(3)
		@tickets = Ticket.recent.limit(10)
		@recommends = Movie.all.limit(4)
		@selections = Event.tagged_with('电影节')
		siteConfigs = SiteConfig.all
		@siteConfig = {}
		for config in siteConfigs
			p config
			@siteConfig[config.property] = config.value
		end
	end

	def welcome
		if user_signed_in?
			redirect_to '/home'
		else
			siteConfigs = SiteConfig.all
			@siteConfig = {}
			for config in siteConfigs
				p config
				@siteConfig[config.property] = config.value
			end
			render 'welcome', :layout => false
		end
	end

	def promote
		render 'promote'
	end
end
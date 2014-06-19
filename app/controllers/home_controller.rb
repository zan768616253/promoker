# coding: utf-8
class HomeController < ApplicationController
	def index
		@projects = Project.published.recent.limit(4)
		@articles = Article.recent.limit(10)
		@events = Event.recent.limit(3)
		@tickets = Ticket.recent.limit(10)
		@recommends = Movie.all.limit(4)
		@partners = Partner.all
		@selections = Event.tagged_with(I18n.t('event.type.filmfest'))
		siteConfigs = SiteConfig.all
		@siteConfig = {}
		for config in siteConfigs
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
				@siteConfig[config.property] = config.value
			end
			render 'welcome', :layout => false
		end
	end

	def marketing
		render 'marketing'
	end

	def contact 
		if request.post?
			Resque.enqueue ContactEmailWorker, params[:contact]
			flash[:notice] = I18n.t('contact_later')
			redirect_to marketing_path
		end
	end
end
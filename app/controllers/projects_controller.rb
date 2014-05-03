class ProjectsController < ApplicationController
	before_filter :authenticate_user!, :except => [:index]
	def index 
		@projects = Project.recent.page(params[:page])
		@tickets = Ticket.recent.page(params[:page])
		@types = Tag.tags_on('movie_type')
		@roles = Tag.tags_on('roles')
		@needs = @roles + Tag.tags_on('needs')
	end

	def show
		@project = Project.find(params[:id])
	end

	def new
		@project = Project.new
	end
	def create
		
	end
end

class ProjectsController < ApplicationController
	before_filter :authenticate_user!, :except => [:index]
	def index 
		@projects = Project.recent.page(params[:page])
		@tickets = Ticket.recent.page(params[:page])
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

# coding: utf-8
class EventsController < ApplicationController
	  before_filter :authenticate_user!, :except => [:index, :show]
	def index
		@locations = Tag.tags_on(:location)
		@types = Tag.tags_on(:event_type)
    	if(params[:location] || params[:type])
    		if params[:status]
      			@events = Event.tagged_with([params[:location], params[:type]]).page(params[:page]).where(:status => params[:status])
      		else
      			@events = Event.tagged_with([params[:location], params[:type]]).page(params[:page])
      		end
    	else
    		if params[:status]
      			@events = Event.where(:status => params[:status]).page(params[:page])
      		else
      			@events = Event.all.page(params[:page])
      		end
    	end
	end
	def show
		@event = Event.find(params[:id])
	end

	def like 
		event = Event.find(params[:id])
		event.liked_by current_user
		render :text => event.likes.size
	end
	def unlike
		event = Event.find(params[:id])
		event.unliked_by current_user
		render :text => event.likes.size
	end
end

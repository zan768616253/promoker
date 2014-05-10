class EventsController < ApplicationController
	def index
		p params
		@locations = Tag.tags_on(:location)
		@types = Tag.tags_on(:event)
    	if(params[:location] || params[:type])
      		@events = Event.tagged_with([params[:location], params[:type]]).page(params[:page])
    	else
      		@events = Event.all.page(params[:page])
    	end
	end
	def show
		@event = Event.find(params[:id])
	end

	def like 
		e = Event.find(params['event_id'])
		e.liked_by current_user
		render :text => e.likes.size
	end
	def unlike
		e = Event.find(params['event_id'])
		e.unliked_by current_user
		render :text => e.likes.size
	end
end

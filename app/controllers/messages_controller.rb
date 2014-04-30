class MessagesController < ApplicationController
	before_action :authenticate_user!
	def index
		@messages = Message.recent(current_user).page(params[:page])
	end

	def show 
		@message = Message.find(params[:id])
		@message.read = true
		@message.save!
	end

	def create
		message = Message.new
		message.to_id = params['message']['to']
		message.content = params['message']['content']
		message.from_id = current_user.id
		message.save
		redirect_to user_path(params['message']['to'])
	end		
end

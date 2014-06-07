class MessagesController < ApplicationController
	before_action :authenticate_user!
	def index
		@messages = Message.recent(current_user).page(params[:page])
	end

	def show 
		@message = Message.find(params[:id])
		if @message.to != current_user and @message.from != current_user
			render_404
		else
			@message.is_read = true
			@message.save!
		end
	end

	def create
		message = Message.new
		message.to_id = params['message']['to']
		message.content = params['message']['content']
		message.from_id = current_user.id
		message.save
		redirect_to user_path(params['message']['to'])
	end		

	def mark
		messages = Message.unread(current_user)
		for message in messages
			message.is_read = true
			message.save
		end
		redirect_to messages_path
	end
end

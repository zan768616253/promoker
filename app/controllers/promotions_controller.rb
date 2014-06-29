# coding: utf-8
class PromotionsController < ApplicationController
	# draft received, promoting, complete
	before_filter :authenticate_user!, :except => [:show]
	before_filter :find_promotion, :except => [:index, :create]
	before_filter :current_user!, :except => [:create]

	def find_promotion
		@promotion = Promotion.find(params[:id])
	end

	def create
		@promotion = Promotion.new
		@promotion.title = params[:promotion][:title]
		@promotion.user = current_user
		if @promotion.save
			redirect_to promotion_path(@promotion)
		else
			flash[:error] = "创建失败"
			redirect_to root_url
		end
	end

	def update
		if params[:promotion].blank?
			flash[:error] = "请提交申请文件"
			redirect_to :back
		else
			@promotion = Promotion.find(params[:id])
			@promotion.file = params[:promotion][:file]
			@promotion.state = "received"
			if @promotion.save
				flash[:alert] = "提交成功，请等待审核"
				redirect_to :back	
			else
				flash[:error] = "提交失败，请重新提交: " + @promotion.errors.messages[:file].join(' ')
				redirect_to :back
			end
		end
	end

	def index
		@promotions = current_user.promotions
	end

	def show

	end

	protected
	def current_user!
	    if @promotion.user != current_user
	      redirect_to root_path
	    end
  	end

  	def promotion_params
		params.require(:promotion).permit!
	end
end
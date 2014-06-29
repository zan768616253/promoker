# coding: utf-8
class PromotionsController < ApplicationController
	before_filter :authenticate_user!, :except => [:show]
	before_filter :find_promotion, :except => [:index, :create]
	before_filter :current_user!, :except => [:index, :create]

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
			flash[:error] = I18n.t('promotion.create.failed')
			redirect_to root_url
		end
	end

	def update
		if params[:promotion].blank?
			flash[:error] = I18n.t('promotion.update.not_found')
			redirect_to :back
		else
			@promotion = Promotion.find(params[:id])
			@promotion.file = params[:promotion][:file]
			@promotion.state = "received"
			if @promotion.save
				flash[:alert] = I18n.t('promotion.update.success')
				redirect_to :back	
			else
				flash[:error] = I18n.t('promotion.update.failed') + @promotion.errors.messages[:file].join(' ')
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
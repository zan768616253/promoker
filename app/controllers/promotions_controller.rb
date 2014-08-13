# coding: utf-8
class PromotionsController < ApplicationController
	before_filter :authenticate_user!
	before_filter :find_promotion, :except => [:index, :create, :maike]
	before_filter :current_user!, :except => [:index, :create, :maike]

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
	    session[:last_promotion] = params[:id]
	end

	def maike
		unless session[:last_promotion].nil? || params[:state].blank?
			@promotion = Promotion.find session[:last_promotion]
			@promotion.state = params[:state]
			@promotion.save!
			redirect_to promotion_path(@promotion)
		else
			redirect_to home_path
		end
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
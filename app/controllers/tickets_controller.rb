# coding: utf-8
class TicketsController < ApplicationController
	before_filter :authenticate_user!, :except => [:show]
	def show
		@ticket = Ticket.find(params[:id])
		@user = @ticket.user
		render 'show', layout: false
	end
	def create
		p params[:ticket]
		@ticket = Ticket.new
		@ticket.need_list = params[:ticket][:needs]
		@ticket.title = params[:ticket][:title]
		@ticket.contact = params[:ticket][:contact]
		@ticket.user = current_user
		unless params[:ticket][:province].blank?
	      province = Province.find(params[:ticket][:province])
	      province_name = province.name unless province.nil?
	      params[:ticket][:province] = province_name
	      params[:ticket][:location] = province_name + ' '
	    end
	    unless params[:ticket][:city].blank?
	      city = City.find(params[:ticket][:city])
	      city_name = city.name unless city.nil?
	      params[:ticket][:city] = city_name
	      params[:ticket][:location] += city_name + ' '
	    end
	    @ticket.province = params[:ticket][:province]
		@ticket.city = params[:ticket][:city]
	    @ticket.location = params[:ticket][:location]
		respond_to do |format|
	      if @ticket.save
	        format.html { 
	        	flash[:alert] = '发布成功'
	        	redirect_to :back 
	        }
	        format.js
	      else
	        format.html { 
	        	flash[:error] = '发布失败'
	        	redirect_to :back 
	        }
	        format.js
	      end
    	end
	end
end

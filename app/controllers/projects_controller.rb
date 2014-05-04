# coding: utf-8
class ProjectsController < ApplicationController
	before_filter :authenticate_user!, :except => [:index]
	def index 
		@projects = Project.recent.page(params[:page])
		@tickets = Ticket.recent.page(params[:page])
	end


	def edit 
		@project = Project.find(params[:id])
		@types = Tag.tags_on('movie_type')
		@roles = Tag.tags_on('roles')
		@needs = @roles + Tag.tags_on('needs')
	end

	def show
		@project = Project.find(params[:id])
		if @project.status != 'published'
			render_404 and return
		end
		@user = @project.user
	end

	def create
		@project = Project.new
		@project.title = params[:project][:title]
		@project.user = current_user
		if @project.save
			redirect_to edit_project_path(@project)
		else
			flash[:error] = "创建失败"
			redirect_to root_url
		end
	end

	def update
		p params
		@project = Project.find(params[:id])
		if @project.user != current_user
			render_403
		end
		needs = params[:project][:needs]
		params[:project].delete(:needs)
		unless params[:project][:province].blank?
	      province = Province.find(params[:project][:province])
	      province_name = province.name unless province.nil?
	      params[:project][:province] = province_name
	      params[:project][:location] = province_name + ' '
	    end
	    unless params[:project][:city].blank?
	      city = City.find(params[:project][:city])
	      city_name = city.name unless city.nil?
	      params[:project][:city] = city_name
	      params[:project][:location] += city_name + ' '
	    end
		@project.update_attributes(project_params)
		@project.need_list = needs
		respond_to do |format|
			if @project.save
				format.html { 
					flash[:alert] = '更新成功！'
					redirect_to edit_project_path(@project) 
				}
        		format.js
      		else
        		format.html { redirect_to edit_project_path(@project) }
        		format.js
			end
		end
	end

	def publish

	end

	def preview
		@project = Project.find(params[:id])
		if @project.user != current_user
			render_404 and return
		end
		@user = current_user
		render 'preview'
	end

	private 
	def project_params
		params.require(:project).permit!
	end
end

# coding: utf-8
class ProjectsController < ApplicationController
	before_filter :authenticate_user!, :except => [:index, :show]
	before_filter :find_project, :except => [:index, :create]
  	before_filter :current_user!, :except => [:index, :show, :create]
	

	def find_project
		@project = Project.find(params[:id])
	end

	def current_user!
	    if @project.user != current_user
	      redirect_to root_path
	    end
  	end

	def index 
		@projects = Project.recent.page(params[:page])
		@tickets = Ticket.recent.page(params[:page])
	end

	def show
		if @project.status != 'published'
			render_404 and return
		end
		@user = @project.user
	end

	def edit 
		@types = Tag.tags_on('movie_type')
		@roles = Tag.tags_on('roles')
		@needs = @roles + Tag.tags_on('needs')
	end

	def create
		@project = Project.new
		@project.title = params[:project][:title]
		@project.user = current_user
		@project.start_at = Time.now
		if @project.save
			redirect_to edit_project_path(@project)
		else
			flash[:error] = "创建失败"
			redirect_to root_url
		end
	end

	def update
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
		@project.publish!
		flash[:alert] = "#{@project.title}发布成功"
		redirect_to user_path(@project.user)
	end

	def unpublish
		@project.unpublish!
		flash[:alert] = "#{@project.title}已取消发布"
		redirect_to user_path(@project.user)
	end

	def preview
		@user = @project.user
		render 'preview'
	end

	private 
	def project_params
		params.require(:project).permit!
	end
end

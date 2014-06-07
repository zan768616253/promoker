# coding: utf-8
require 'spec_helper'

describe ProjectsController do
	render_views
	let(:user) { create(:user) }
	let(:user_test) { create(:user) }
	let(:project) { create(:project, :user => user) }
	let(:published_project) { create(:project, :published, :user => user) }

	describe "GET index" do
		it "should return success" do
			get :index
			response.should be_success
		end
	end	
	describe "GET show" do
	 	it "should redirect to 404 page if no published project found" do
	 		get :show, :id => project.id
	 		response.should render_template('errors/404')
	 	end
	 	it "should return success if published project found" do
	 		get :show, :id => published_project.id
	 		response.should be_success
	 	end
	end
	describe "GET edit" do
	    it "should redirect to user sign in page if not signed in" do
			get :edit, :id => project.id
			response.should redirect_to new_user_session_path
		end
		it "should redirect to 404 page if no project found" do
			sign_in user
	 		get :edit, :id => 100
	 		response.should render_template('errors/404')
	 	end
		it "should redirect to root page if current_user is not owner of the project" do
	  		sign_in user_test
	  		get :edit, :id => project.id
	  		response.should redirect_to root_path
	  	end
	  	it "should render edit page if successful" do
	  		sign_in user
	  		get :edit, :id => project.id
	  		response.should render_template('edit')
	  	end
	end
	describe "POST create" do
		it "should redirect to user sign in page if not signed in" do
			post :create, :id => project.id
			response.should redirect_to new_user_session_path
		end
		it "should redirect to project edit page if successful" do
	  		sign_in user
	  		post :create, :project => { title: Faker::Lorem.sentence }
	  		response.should redirect_to edit_project_path(Project.last)
	  	end
	end
	describe "PUT update" do
		it "should redirect to user sign in page if not signed in" do
			put :update, :id => project.id
			response.should redirect_to new_user_session_path
		end
		it "should redirect to 404 page if no project found" do
			sign_in user
	 		put :update, :id => 100
	 		response.should render_template('errors/404')
	 	end
		it "should redirect to root page if current_user is not owner of the project" do
	  		sign_in user_test
	  		put :update, :id => project.id
	  		response.should redirect_to root_path
	  	end
	  	it "should redirect to project edit page if successful" do
	  		sign_in user
	  		put :update, :id => project.id, :project => { :title => Faker::Lorem.sentence }
	  		flash[:alert].should eq('更新成功！')
	  		response.should redirect_to edit_project_path(project)
	  	end
	end
	describe "POST publish" do
		it "should redirect to user sign in page if not signed in" do
			post :publish, :id => project.id
			response.should redirect_to new_user_session_path
		end
		it "should redirect to 404 page if no project found" do
			sign_in user
	 		post :publish, :id => 100
	 		response.should render_template('errors/404')
	 	end
	  	it "should redirect to root page if current_user is not owner of the project" do
	  		sign_in user_test
	  		post :publish, :id => project.id
	  		response.should redirect_to root_path
	  	end
	  	it "should redirect to user page and show successful flash if successful" do
	  		sign_in user
	  		post :publish, :id => project.id
	  		flash[:alert].should eq("#{project.title}发布成功")
	  		response.should redirect_to user_path(user)
	  	end
	end
	describe "POST unpublish" do
		it "should redirect to user sign in page if not signed in" do
			post :unpublish, :id => project.id
			response.should redirect_to new_user_session_path
		end
		it "should redirect to 404 page if no project found" do
			sign_in user
	 		post :unpublish, :id => 100
	 		response.should render_template('errors/404')
	 	end
	  	it "should redirect to root page if current_user is not owner of the project" do
	  		sign_in user_test
	  		post :unpublish, :id => project.id
	  		response.should redirect_to root_path
	  	end
	  	it "should redirect to user page and show successful flash if successful" do
	  		sign_in user
	  		post :unpublish, :id => project.id
	  		flash[:alert].should eq("#{project.title}已取消发布")
	  		response.should redirect_to user_path(user)
	  	end
	end
	describe "GET preview" do
		it "should redirect to user sign in page if not signed in" do
			get :preview, :id => project.id
			response.should redirect_to new_user_session_path
		end
		it "should redirect to 404 page if no project found" do
			sign_in user
	 		get :preview, :id => 100
	 		response.should render_template('errors/404')
	 	end
		it "should redirect to root page if current_user is not owner of the project" do
	  		sign_in user_test
	  		get :preview, :id => project.id
			response.should redirect_to root_path
	  	end
	  	it "should render preview page" do
	  		sign_in user
	  		get :preview, :id => project.id
	  		response.should render_template('preview')
	  	end
	end
end

# coding: utf-8
require 'spec_helper'

describe UsersController do
	render_views
	let(:user) { create(:user) }
	let(:user_test) { create(:user) }
	describe "POST update_avatar" do
		it "should rediect to signed in page if not signed in" do
			post :update_avatar, :id => user.id
			response.should redirect_to new_user_session_path
		end
		it "should render 404 page if user not found" do
			sign_in user
			post :update_avatar, :id => 100
			response.should render_template('errors/404')
		end
		it "should rediect to root page if user not current_user" do
			sign_in user_test
			post :update_avatar, :id => user.id
			response.should redirect_to root_path
		end
		it "should update avatar if successful" do
			sign_in user
			path = "#{Rails.root}/spec/support/users/avatars/1.jpeg"
	  		post :update_avatar, :id => user.id, :user => {
	  			:avatar => fixture_file_upload(path, 'image/jpeg'),
	  			:crop => {
	  				:w => 100,
	  				:h => 100,
	  				:x1 => 0,
	  				:y1 => 0
	  			}
	  		}	
	  		flash[:alert].should eq('更新成功')
	  		response.should redirect_to edit_user_path(user)
		end
	end

	describe "GET show" do
		it "should render 404 page if user not found" do
			get :show, :id => 100
			response.should render_template('errors/404')
		end
		it "should render show page if not signed in" do
			get :show, :id => user.id
			response.should render_template('show')
		end
		it "should render show page if user page is not belonged to current user" do
			sign_in user_test
			get :show, :id => user.id
			response.should render_template('show')
		end
		it "should render dashboard page if user page is belonged to current user" do
			sign_in user
			get :show, :id => user.id
			response.should render_template('dashboard')
		end
	end

	describe "GET edit" do
		it "should redirect to sign in page if not signed in" do
			get :edit, :id => user.id
			response.should redirect_to new_user_session_path
		end
	    it "should render 404 page if user not found" do
	    	sign_in user
			get :edit, :id => 100
			response.should render_template('errors/404')
		end
		it "should redirect to root page if user page is not belonged to current_user" do
			sign_in user_test
			get :edit, :id => user.id
			response.should redirect_to root_path
		end
		it "should render user edit page if successful" do
			sign_in user
			get :edit, :id => user.id
			response.should render_template('edit')
		end
	end
	describe "PUT update" do
		it "should redirect to sign in page if not signed in" do
			put :update, :id => user.id
			response.should redirect_to new_user_session_path
		end
		it "should render 404 page if user not found" do
	    	sign_in user
			put :update, :id => 100
			response.should render_template('errors/404')
		end
		
		it "should redirect to root page if user page is not belonged to current_user" do
			sign_in user_test
			put :update, :id => user.id
			response.should redirect_to root_path
		end
		it "should update user if successful" do
			sign_in user
			put :update, :id => user.id, :user => {
				:nickname => Faker::Name.name
			}
			flash[:alert].should eq("更新成功")
			response.should redirect_to edit_user_path(user)
		end	
	end

	describe "POST follow" do
		before(:each) do
			request.accept = "application/json"
		end
		it "should redirect to sign in page if not signed in" do
			post :follow, :id => user.id
			response.status.should eq(401)
		end
		it "should render 404 page if user not found" do
	    	sign_in user
			post :follow, :id => 100
			response.should render_template('errors/404')
		end
		
		it "should follow user if successful" do
			sign_in user_test
			post :follow, :id => user.id
			response.should be_success
		end	
	end

	describe "POST unfollow" do
		before(:each) do
			request.accept = "application/json"
		end
		it "should redirect to sign in page if not signed in" do
			post :unfollow, :id => user.id
			response.status.should eq(401)
		end
		it "should render 404 page if user not found" do
	    	sign_in user
			post :unfollow, :id => 100
			response.should render_template('errors/404')
		end
		
		it "should follow user if successful" do
			sign_in user_test
			post :unfollow, :id => user.id
			response.should be_success
		end	
	end
end

require 'spec_helper'

describe EventsController do
	render_views
	let(:user)  { create(:user) }
	let(:event) { create(:event)}
	describe "GET index" do
	  it "should return success" do
	  	get :index
	  	response.should be_success
	  end
	end
	describe "GET show" do
	  it "should return success" do
	  	get :show, :id => event.id
	  	response.should be_success 
	  end
	end

	describe "POST like" do
	  it "should rediect to sign in page if not signed in" do
	  	post :like, :id => event.id
	  	response.should redirect_to new_user_session_path
	  end
	  it "should return success" do
	  	sign_in user
	  	post :like, :id => event.id
	  	response.should be_success
	  end
	end

	describe "POST unlike" do
	  it "should rediect to sign in page if not signed in" do
	  	post :like, :id => event.id
	  	response.should redirect_to new_user_session_path
	  end
	  it "should return success" do
	  	sign_in user
	  	post :unlike, :id => event.id
	  	response.should be_success
	  end
	end
end

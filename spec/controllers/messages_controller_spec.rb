require 'spec_helper'

describe MessagesController do
	render_views
	let(:user) { create(:user) }
	let(:message) { create(:message)}
	describe "GET index" do
	  it "should redirect to sign in page if not signed in" do
	  	get :index
	  	response.should redirect_to new_user_session_path
	  end
	  it "should return success" do
	  	sign_in user
	  	get :index
	  	response.should be_success
	  end
	  
	end
	describe "GET show" do
	  it "should redirect to sign in page if not signed in" do
	  	get :show, :id => article.id
	  	response.should be_success 
	  end
	  it "should return success" do
	  	sign_in user
	  	get :show, :id => message.id
	  	response.should be_success 
	  end
	  if "should render 404 page if not found"
	  	
	  end
	end

end

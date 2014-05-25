# coding: utf-8
require 'spec_helper'

describe TicketsController do
	let(:user) { create(:user) }
	let(:ticket) { create(:ticket)}
	describe "GET show" do
	  it "should return success" do
	  	get :show, :id => ticket.id
	  	response.should be_success 
	  	response.should render_template('show')
	  end
	end
	describe "POST create" do
	  before(:each) do
    	request.env["HTTP_REFERER"] = root_path
  	  end
	  it "should rediect to signed in page if not signed in" do
	  	post :create, :ticket => {
	  		title: Faker::Lorem.sentence
	  	} 
	  	response.should redirect_to new_user_session_path
	  end
	  it "should redirect back to root path if signed in" do
	  	sign_in user
	  	post :create, :ticket => {
	  		title: Faker::Lorem.sentence
	  	}
	  	flash[:alert].should eq('发布成功') 
	  	response.should redirect_to root_path
	  end
	  it "should create a ticket successfully" do
	  	sign_in user
	  	post :create, :ticket => {
	  		title: Faker::Lorem.sentence
	  	}
	  	flash[:alert].should eq('发布成功') 
	  	response.should redirect_to root_path
	  end
	  it "should be failed to create a ticket" do
	 	sign_in user
	 	post :create, :ticket => {

	 	}
	 	flash[:error].should eq('发布失败')
	 	response.should redirect_to root_path
	  end
	end
end

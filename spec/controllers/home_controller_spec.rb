# coding: utf-8
require 'spec_helper'

describe HomeController do
	describe "GET :index" do
		it "should return success" do
			get :index
			response.should be_success
		end			
	end
	describe "GET :welcome" do
		let(:user) {create(:user)}
		it "should return success" do
			get :welcome
			response.should be_success
		end
		it "should render welcome"	do
			get :welcome
			response.should render_template('welcome')
		end

		it "should redirect to index page if user signed in" do
			sign_in user
			get :welcome
			response.should redirect_to '/home'
		end
	end
end

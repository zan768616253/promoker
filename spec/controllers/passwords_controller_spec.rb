# coding: utf-8
require 'spec_helper'

describe PasswordsController do
  	render_views
  	let(:user) { create(:user) }
  	let(:user_test) { create(:user) }
  	describe "PUT update" do
	it "should rediect to signed in page if not signed in" do
	  	put :update, :id => user.id
	  	response.should redirect_to new_user_session_path
	end
	it "should show error flash if current password not correct" do
		sign_in user
		put :update, :id => user.id, :user => {
			:current_password => '12345678',
			:password => 'newpassword',
			:password_confirmation => 'newpassword'
		}
		flash[:alert].should eq('密码更新失败')
		response.should redirect_to edit_user_path(user)		
	end
	it "should show error flash if password is not matched with password_confirmation" do
		sign_in user
		put :update, :id => user.id, :user => {
			:current_password => 'passowrd',
			:password => 'newpassword',
			:password_confirmation => 'oldpassword'
		}
		flash[:alert].should eq('密码更新失败')
		response.should redirect_to edit_user_path(user)		
	end
	it "should update the password if successful" do
		sign_in user
		put :update, :id => user.id, :user => {
			:current_password => 'password',
			:password => 'newpassword',
			:password_confirmation => 'newpassword'
		}
		flash[:alert].should eq('密码更新成功')
		response.should redirect_to edit_user_path(user)		
	end

  end
end
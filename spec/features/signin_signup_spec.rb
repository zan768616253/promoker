#encoding: utf-8
feature "Sign in and Sign up" do
	let(:user) { create(:user) }  
	let(:filmfests) { create_list(:event, 5, :filmfest) }
	context 'modal' do
		context 'sign in' do
		  	scenario "sign in with correct credentials" do
		    	visit home_path
		    	click_link '登录'
		    	fill_in 'user_email', with: user.email
		    	fill_in 'user_password', with: user.password
		    	click_button '登录'
		    	page.should have_content('我的主页')
			end
			scenario "sign in with incorrect credentials" do
		    	visit home_path
		    	click_link '登录'
		    	fill_in 'user_email', with: user.password
		    	fill_in 'user_password', with: 'wrongpassword'
		    	click_button '登录'
		    	page.should have_content('我的主页')
			end
		end
		scenario "sign up" do
	    	visit home_path
	    	click_link '注册'
	    	fill_in 'user_email', with: user.email
	    	fill_in 'user_nickname',  with: user.name
	    	fill_in 'user_password', with: user.password
	    	fill_in 'user_password_confirmation', with: user.password_confirmation
	    	click_button '注册'
	    	save_and_open_page
	    	page.should have_content('我的主页')
		end
	end
	context 'page' do
		scenario "sign in with correct credentials" do
	    	visit new_user_session_path
	    	fill_in 'user_email', with: user.email
	    	fill_in 'user_password', with: user.password
	    	click_button '登录'
	    	page.should have_content('我的主页')
		end
	end
end
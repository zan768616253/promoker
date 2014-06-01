#encoding: utf-8
feature "Sign in and Sign up" do
	let(:user) { create(:user) }  
	let(:filmfests) { create_list(:event, 5, :filmfest) }
	context 'modal' do
		context 'sign in' do
		  	scenario "sign in with correct credentials" do
		    	visit home_path
		    	click_link '登录'
		    	within("#login") do
			    	fill_in 'user_email', with: user.email
			    	fill_in 'user_password', with: user.password
			    end
		    	click_button '登录'
		    	page.should have_content('我的主页')
			end
			scenario "sign in with incorrect credentials" do
		    	visit home_path
		    	click_link '登录'
		    	within("#login") do
			    	fill_in 'user_email', with: user.email
			    	fill_in 'user_password', with: 'wrongpassword'
			    end
		    	click_button '登录'
		    	page.should have_content('邮箱或密码错误.')
			end
		end
		context 'sign up' do
			scenario "sign up with existing user info" do
		    	visit home_path
		    	click_link '注册'
		    	within("#register") do
			    	fill_in 'user_email', with: user.email
			    	fill_in 'user_nickname',  with: user.name
			    	fill_in 'user_password', with: user.password
		    		fill_in 'user_password_confirmation', with: user.password_confirmation
		    	end
		    	click_button '注册'
		    	page.should have_content('邮箱 已经被注册啦')
			end
			scenario "sign up with blank passowrd" do
				visit new_user_registration_path
		    	click_link '注册'
		    	within("#register") do
			    	fill_in 'user_email', with: Faker::Internet.email
			    	fill_in 'user_nickname',  with: Faker::Name.name
			    	fill_in 'user_password', with: ""
		    		fill_in 'user_password_confirmation', with: ""
		    	end
		    	click_button '注册'
		    	page.should have_content("密码 不能为空字符")
			end
			scenario "sign up with passowrd mismatch" do
				visit home_path
		    	click_link '注册'
		    	within("#register") do
			    	fill_in 'user_email', with: Faker::Internet.email
			    	fill_in 'user_nickname',  with: Faker::Name.name
			    	fill_in 'user_password', with: "password"
		    		fill_in 'user_password_confirmation', with: "wrongpassword"
		    	end
		    	click_button '注册'
		    	page.should have_content("确认密码 和密码不一致哦")
			end
			scenario "sign up with new user info" do
		    	visit home_path
		    	click_link '注册'
		    	within("#register") do
			    	fill_in 'user_email', with: Faker::Internet.email
			    	fill_in 'user_nickname',  with: Faker::Name.name
			    	fill_in 'user_password', with: "password"
		    		fill_in 'user_password_confirmation', with: "password"
		    	end
		    	click_button '注册'
		    	page.should have_content('我的主页')
			end
		end
	end
	context 'page' do
		context 'sign in' do
			scenario "sign in with correct credentials" do
		    	visit new_user_session_path
		    	fill_in 'user_email', with: user.email
		    	fill_in 'user_password', with: user.password
		    	click_button '登录'
		    	page.should have_content('我的主页')
			end
			scenario "sign in with incorrect credentials" do
		    	visit new_user_session_path
		    	fill_in 'user_email', with: user.email
		    	fill_in 'user_password', with: Faker::Lorem.word
		    	click_button '登录'
		    	page.should have_content('邮箱或密码错误.')
			end
		end
		context 'sign up' do
			scenario "sign up with existing user info" do
		    	visit new_user_registration_path
		    	click_link '注册'
		    	fill_in 'user_email', with: user.email
		    	fill_in 'user_nickname',  with: user.name
		    	fill_in 'user_password', with: user.password
	    		fill_in 'user_password_confirmation', with: user.password_confirmation
		    	click_button '注册'
		    	page.should have_content('邮箱 已经被注册啦')
			end
			scenario "sign up with passowrd mismatch" do
				visit new_user_registration_path
		    	click_link '注册'
		    	fill_in 'user_email', with: Faker::Internet.email
		    	fill_in 'user_nickname',  with: Faker::Name.name
		    	fill_in 'user_password', with: "password"
	    		fill_in 'user_password_confirmation', with: "wrongpassword"
		    	click_button '注册'
		    	page.should have_content("确认密码 和密码不一致哦")
			end
			scenario "sign up with blank passowrd" do
				visit new_user_registration_path
		    	click_link '注册'
		    	fill_in 'user_email', with: Faker::Internet.email
		    	fill_in 'user_nickname',  with: Faker::Name.name
		    	fill_in 'user_password', with: ""
	    		fill_in 'user_password_confirmation', with: ""
		    	click_button '注册'
		    	page.should have_content("密码 不能为空字符")
			end
			scenario "sign up with new user info" do
		    	visit new_user_registration_path
		    	click_link '注册'
		    	fill_in 'user_email', with: Faker::Internet.email
		    	fill_in 'user_nickname',  with: Faker::Name.name
		    	fill_in 'user_password', with: "password"
	    		fill_in 'user_password_confirmation', with: "password"
		    	click_button '注册'
		    	page.should have_content('我的主页')
			end
		end
	end
end
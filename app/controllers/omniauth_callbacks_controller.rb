# encoding: UTF-8
class OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def self.providers_callback_for(*providers)
    providers.each do |provider|
      class_eval %Q{
        def #{provider}
          if not current_user.blank?
            provider = env["omniauth.auth"]["provider"]
            uid = env["omniauth.auth"]["uid"]
            if Authorization.exists?(:provider => provider, :uid => uid)
              redirect_to session[:previous_url], :alert => "该微博帐号已被其他用户绑定 !"
            else
              if current_user.avatar.nil?
                current_user.avatar = env["omniauth.auth"]["info"]["image"]
                current_user.save
              end
              current_user.bind_service(env["omniauth.auth"])#Add an auth to existing
              redirect_to session[:previous_url], :notice => "成功绑定了 #{provider} 帐号。"
            end

          else
            @user = User.find_or_create_for_#{provider}(env["omniauth.auth"])
            flash[:notice] = "登陆成功。"
            sign_in_and_redirect @user, :event => :authentication
          end
        end
      }
    end
  end
  providers_callback_for :weibo
end

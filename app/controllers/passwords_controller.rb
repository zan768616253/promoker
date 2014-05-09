# coding: utf-8
class PasswordsController < ApplicationController
  before_filter :authenticate_user!

  def update
    @user = current_user

    # Devise::Models::DatabaseAuthenticatable#update_with_password
    # Update record attributes when :current_password matches, otherwise returns error on :current_password.
    # It also automatically rejects :password and :password_confirmation if they are blank.
    if @user.update_with_password(user_params)

      # Sign in the user bypassing validation in case his password changed
      sign_in @user, :bypass => true

      redirect_to edit_user_path(@user), :notice => "密码更新成功"
    else

      #flash[:alert] = @user.errors.full_messages.join("<br />")
      flash[:alert] = '密码更新失败'
      render :template => "users/edit"
    end
  end

  private 
  def user_params
    params.require(:user).permit!
  end
end
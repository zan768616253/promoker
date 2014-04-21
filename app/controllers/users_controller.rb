# coding: utf-8
class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    if current_user.id == @user.id
      render 'dashboard'
    else
      render 'show'
    end

  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    params[:user][:nickname] = params[:user][:nickname].strip
    unless params[:user][:province].empty?
      province = Province.find(params[:user][:province])
      province_name = province.name unless province.nil?
      params[:user][:location] = province_name + ' '
    end
    unless params[:user][:city].empty?
      city = City.find(params[:user][:city])
      city_name = city.name unless city.nil?
      params[:user][:location] += city_name + ' '
    end
    unless params[:user][:district].empty?
      district = District.find(params[:user][:district])
      district_name = district.name unless district.nil?
      params[:user][:location] += district_name + ' '
    end

    respond_to do |format|
      if @user.update_attributes(params.require(:user).permit!)
        format.html {
          redirect_to edit_user_path(@user), :notice => "更新成功"
        }
      else
        format.html {
          render action: 'edit'
        }
      end
    end

  end

  def likes
    p params
  end
end

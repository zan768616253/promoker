# coding: utf-8
class UsersController < ApplicationController
  def update_avatar
    p params
    @user = User.find(params[:user_id])
    if @user.nil?
      redirect_to root_url
    end
    @user.avatar = cropped_image(params[:user])
    if @user.save
      redirect_to edit_user_path(@user), :notice => "更新成功"
    else
      render action: 'edit'
    end
  end

  def show
    @user = User.find(params[:id])
    if @user.nil?
      redirect_to root_url
    end

    @likes = @user.find_votes.order('created_at desc')
    @liked_items = @user.find_liked_items.reverse

    @tickets = @user.tickets
    @projects = @user.projects
    if not current_user.nil? and current_user.id == @user.id
      @followings = @user.all_following
      render 'dashboard'
    else
      render 'show'
    end

  end

  def edit
    @user = User.find(params[:id])
    @roles = Tag.tags_on('roles')
  end

  def update
    @user = User.find(params[:id])
    if @user.nil?
      render_404 and return
    end
    roles = params[:user][:roles]
    params[:user].delete(:roles)
    params[:user][:nickname] = params[:user][:nickname].strip
    params[:user][:name] = params[:user][:nickname]
    unless params[:user][:province].blank?
      province = Province.find(params[:user][:province])
      province_name = province.name unless province.nil?
      params[:user][:province] = province_name
      params[:user][:location] = province_name + ' '
    end
    unless params[:user][:city].blank?
      city = City.find(params[:user][:city])
      city_name = city.name unless city.nil?
      params[:user][:city] = city_name
      params[:user][:location] += city_name + ' ' if city_name != province_name
    end
    unless params[:user][:district].blank?
      district = District.find(params[:user][:district])
      district_name = district.name unless district.nil?
      params[:user][:location] += district_name + ' '
    end
    @user.update_attributes(user_params)
    @user.role_list = roles
    respond_to do |format|
      if @user.save
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

  def follow
    p params
    @user = User.find(params[:id])
    current_user.follow(@user)
  end

  def unfollow
    p params
    @user = User.find(params[:id])
    current_user.stop_following(@user)
  end

  private 
  def user_params
    params.require(:user).permit!
  end

  def cropped_image(params)
    image = MiniMagick::Image.open(params[:avatar].path)
    crop_params = "#{params[:crop][:w]}x#{params[:crop][:h]}+#{params[:crop][:x1]}+#{params[:crop][:y1]}"
    p crop_params
    image.crop(crop_params)
    image
  end
end

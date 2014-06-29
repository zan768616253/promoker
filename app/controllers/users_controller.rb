# coding: utf-8
class UsersController < ApplicationController
  before_filter :authenticate_user!, :except => [:show]
  before_filter :find_user
  before_filter :current_user!, :except => [:show, :follow, :unfollow]

  def find_user 
    @user = User.find(params[:id])
  end

  def current_user!
    if @user != current_user
      redirect_to root_path
    end
  end

  def update_avatar
    @user.avatar = cropped_image(params[:user])
    if @user.save
      flash[:alert] = I18n.t('users.update.success')
      redirect_to edit_user_path(@user)
    else
      flash[:alert] = I18n.t('users.update.failed') + @user.errors.messages[:avatar].join(' ')
      redirect_to edit_user_path(@user)
    end
  end

  def show
    @likes = @user.find_votes.order('created_at desc')
    @liked_items = @user.find_liked_items.reverse
    @tickets = @user.tickets
    
    if not current_user.nil? and current_user.id == @user.id
      @projects = @user.projects.page(params[:page])
      @followings = @user.all_following
      render 'dashboard'
    else
      @projects = @user.published_projects.page(params[:page])
      render 'show'
    end
  end

  def edit
    @roles = Tag.tags_on('roles') || []
  end

  def update
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
          flash[:alert] = I18n.t('users.update.success')
          redirect_to edit_user_path(@user)
        }
      else
        format.html {
          render action: 'edit'
        }
      end
    end

  end

  def follow
    respond_to do |format|
      if current_user.follow(@user)
        format.json { render :json => { success: true} }
      else
        format.json { render :json => { success: false} }
      end
    end
  end

  def unfollow
    respond_to do |format|
      if current_user.stop_following(@user)
        format.json { render :json => { success: true} }
      else
        format.json { render :json => { success: false} }
      end
    end
  end

  private 
  def user_params
    params.require(:user).permit!
  end

  def cropped_image(params)
    image = MiniMagick::Image.open(params[:avatar].path)
    crop_params = "#{params[:crop][:w]}x#{params[:crop][:h]}+#{params[:crop][:x1]}+#{params[:crop][:y1]}"
    image.crop(crop_params)
    image
  end
end

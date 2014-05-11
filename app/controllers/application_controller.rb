class ApplicationController < ActionController::Base

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  after_filter :store_location

  def store_location
    # store last url - this is needed for post-login redirect to whatever the user last visited.
    if (request.fullpath != "/users/sign_in" &&
       request.fullpath != "/users/sign_up" &&
       request.fullpath != "/users/password" &&
       request.fullpath != "/users/sign_out" &&
       !request.xhr?) # don't store ajax calls
        session[:previous_url] = request.fullpath
        if not params[:reset_password_token].nil?
          session[:previous_url] = root_path
        end
    end
  end

  def after_sign_in_path_for(resource)
    session[:previous_url] || root_path
  end
  def render_404
    render_optional_error_file(404)
  end

  def render_403
    render_optional_error_file(403)
  end

  def render_optional_error_file(status_code)
    status = status_code.to_s
    if ["404","403", "422", "500"].include?(status)
      render :template => "/errors/#{status}", :format => [:html], :handler => [:erb], :status => status, :layout => "application"
    else
      render :template => "/errors/unknown", :format => [:html], :handler => [:erb], :status => status, :layout => "application"
    end
  end


end

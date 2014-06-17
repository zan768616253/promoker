class ApplicationController < ActionController::Base

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :authenticate!
  before_filter :set_locale
  after_filter :store_location
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  def store_location
    if (!request.fullpath.match("/users") &&
        !request.xhr?) # don't store ajax calls
        session[:previous_url] = request.fullpath
    end
  end

  def after_sign_in_path_for(resource)
    session[:previous_url] || home_path
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

  def rescue_routing
    redirect_to home_path
  end

  private
    def authenticate!
      return true unless Rails.env == 'staging'
      authenticate_or_request_with_http_basic do |username, password|
        username == "admin" && password == "promoker"
      end
    end
    def record_not_found
      render_404
    end
    def set_locale
      I18n.locale = session[:locale] || I18n.default_locale
      session[:locale] = I18n.locale
    end
end

class LocaleController < ApplicationController
  def simplified
    I18n.locale = "zh-CN"
    set_session_and_redirect
  end

  def traditional
    I18n.locale = "zh-HK"
    set_session_and_redirect
  end

  private
  def set_session_and_redirect
    session[:locale] = I18n.locale
    redirect_to :back
    rescue ActionController::RedirectBackError
      redirect_to :root
  end
end
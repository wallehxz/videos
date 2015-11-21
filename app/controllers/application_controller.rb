#coding: utf-8
class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  #protect_from_forgery with: :null_session
  helper_method :current_admin

  def authenticate_admin!
    if session[:admin].nil?
      flash[:notice] ='您还没有管理员权限,请登录'
      redirect_to admin_sign_in_path
    end
  end

  def current_admin
    return session[:admin]
  end

end

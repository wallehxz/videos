#coding: utf-8
class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  #protect_from_forgery with: :null_session
  helper_method :current_admin

  def authenticate_admin!
    unless current_user.present? && current_user.role == 'admin' || session[:admin].present?
      flash[:notice] ='您还没有管理员权限,请登录'
      redirect_to admin_sign_in_path
    end
  end

  def current_admin
    return session[:admin]
  end

  def authenticate_user!
    if current_user.nil?
      redirect_to root_path
    end
  end

  def display_name(user)
    return user.nick_name if user.nick_name.present?
    return user.email if user.nick_name.nil?
  end

  def display_role(user)
    return '苦逼管理员' if user.role=='admin'
    return '荒野大嫖客' if user.role=='fucker'
    return '文艺小骚年' if user.role=='looker'
  end

end

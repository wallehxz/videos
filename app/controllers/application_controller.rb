#coding: utf-8
class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  #protect_from_forgery with: :null_session

  def authenticate_admin!
    if session[:admin].present? || current_user.present? && current_user.level == 1
    else
      flash[:notice] ='您还没有管理员权限,请登录管理账户'
      redirect_to admin_sign_up_path
    end
  end

  def view_user!
    if current_user.present?
      if current_user.level > 0 || current_user.sign_in_count > 100
      else
        redirect_to root_path
      end
    else
      redirect_to root_path
    end
  end

end

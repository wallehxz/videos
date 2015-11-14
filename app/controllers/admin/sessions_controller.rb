#coding: utf-8
require 'rack/auth/digest/md5'
class Admin::SessionsController < ApplicationController
  before_action :authenticate_admin!, only: :style_option
  def sign_up
    render layout: 'LTE_admin_sign'
  end
  #Digest::MD5.hexdigest(local_password)
  def login
    if params[:account].blank? || params[:password].blank?
      flash[:error] = '账号密码不能为空'
      redirect_to admin_sign_up_path
    else
      if Channel.admin_account(params[:account]) == true
        if params[:password] == Settings.password
          session[:admin] = 1
          flash[:success] = '登录成功！可以继续~~~'
          redirect_to admin_dashboard_path
        else
          flash[:error] = '管理员密码有误'
          redirect_to admin_sign_up_path
        end
      else
        flash[:error] = '账户不存在'
        redirect_to admin_sign_up_path
      end
    end
  end

  def logout
    session[:admin] = nil
    redirect_to root_path
  end

  def style_option
    if current_user.present?
      current_style  = UserDetail.find_by_user_id(current_user.id)
      current_style.web_style = params[:style]
      current_style.save
      render 200
    else
      render 400
    end

  end

end


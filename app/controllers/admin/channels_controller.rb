#coding: utf-8
require 'will_paginate'
class Admin::ChannelsController < ApplicationController
  before_action :set_channel, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_admin!
  layout 'LTE_admin'

  def index

    @channels = Channel.order(:id=>:asc)
  end

  def videos

    @all_videos = ChannelVideo.
        order(:is_recommend=> :desc).
        order(:created_at=> :desc).
        paginate(:per_page=>15, :page=>params[:page])
  end

  def update_youku

    @videos = ChannelVideo.all
    @num = 0
    @videos.each do |video|
      if video.youku_json.blank?
        @num += 1
        video.youku_json = ChannelVideo.video_basic(video.youku_id)
        video.save
      end
    end
    render :text => "成功同步#{@num}个视频信息!"
  end

  def show

    @channel_videos = ChannelVideo.
        where(:channel_id => params[:id]).
        order(:is_recommend=> :desc).
        order(:created_at=> :desc).
        paginate(:per_page=>15, :page=>params[:page])
  end

  def new
    @channel = Channel.new
  end

  def edit
  end

  def create
    if params[:channel][:photo_file].present?
      locale_file, file_rename = Channel.qiniu_cache_file(params[:channel][:photo_file])
      put_policy = Qiniu::Auth::PutPolicy.new('meteor',file_rename)
      code, result, response = Qiniu::Storage.upload_with_put_policy(put_policy, locale_file)
      Channel.clear_qiniu_cache(file_rename)
      params[:channel][:cover] = "#{Settings.qiniu_cdn_host + file_rename}"
    end
    @channel = Channel.new(channel_params)
    if @channel.save
      flash[:success] = "「#{@channel.title}」添加成功"
      redirect_to admin_dashboard_path
    else
      flash[:error] = "「#{@channel.title}」表单数据不完整"
      render :new
    end
  end

  def update
    if params[:channel][:photo_file].present?
      locale_file, file_rename = Channel.qiniu_cache_file(params[:channel][:photo_file])
      put_policy = Qiniu::Auth::PutPolicy.new('meteor',file_rename)
      code, result, response = Qiniu::Storage.upload_with_put_policy(put_policy, locale_file)
      Channel.clear_qiniu_cache(file_rename)
      params[:channel][:cover] = "#{Settings.qiniu_cdn_host + file_rename}"
    end
    if @channel.update(channel_params)
      flash[:success] = "「#{@channel.title}」内容更新成功"
      redirect_to admin_dashboard_path
    else
      flash[:error] = "「#{@channel.title}」表单数据不完整"
      render :edit
    end
  end

  def destroy

    @channel.destroy
    flash[:success] = "「#{@channel.title}」所有视频数据删除成功"
    redirect_to admin_dashboard_path
  end

  def search

    if params[:query].present?
      @search_videos = ChannelVideo.
          where(" title like '%#{params[:query]}%' ").
          order(:created_at=> :desc).
          paginate(:per_page=>15, :page=>params[:page])
      flash[:success] = "共计查询到「#{@search_videos.total_entries}」条相关视频"
    else
      flash[:error] = "请输入关键字进行查询"
      redirect_to admin_released_path
    end
  end

  def users

    @users = User.order(:level=> :desc).
        order(:sign_in_count=> :desc).
        paginate(:per_page=>10, :page=>params[:page])
  end

  def set_user_to_admin

    if params[:user_id].present?
      user = User.find(params[:user_id])
      user.level = 1
      user.save
      flash[:success] ="成功将用户「#{user.email}」添加为管理员"
      redirect_to admin_users_path
    elsif params[:admin_id].present?
      admin_user = User.find(params[:admin_id])
      admin_user.level = 0
      admin_user.save
      flash[:warn] ="成功移除用户「#{admin_user.email}」管理权限"
      redirect_to admin_users_path
    elsif params[:view_id].present?
      view_user = User.find(params[:view_id])
      view_user.level = 2
      view_user.save
      flash[:success] ="成功将用户「#{view_user.email}」添加浏览权限"
      redirect_to admin_users_path
    elsif  params[:delete_id].present?
      admin_user = User.find(params[:delete_id])
      admin_user.destroy
      flash[:warn] ="成功删除「#{admin_user.email}」信息"
      redirect_to admin_users_path
    else
      flash[:warn] = '请求参数异常，请重新操作'
      redirect_to admin_users_path
    end
  end

  private

    def set_channel
      @channel = Channel.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def channel_params
      params.require(:channel).permit(:title, :description, :english, :cover)
    end
end

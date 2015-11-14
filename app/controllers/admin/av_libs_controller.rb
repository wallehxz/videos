#coding: utf-8
require 'will_paginate'
class Admin::AvLibsController < ApplicationController
  before_action :set_av_lib, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_admin!
  layout 'LTE_admin'
  respond_to :html

  def index
    @av_libs = AvLib.order(:created_at=> :desc).order(:av_type).paginate(:per_page=>15, :page=>params[:page])
  end

  def show
  end

  def new
    @av_lib = AvLib.new
  end

  def edit
  end

  def create
    if params[:av_lib][:photo_file].present?
      locale_file, file_rename = Channel.qiniu_cache_file(params[:av_lib][:photo_file])
      put_policy = Qiniu::Auth::PutPolicy.new('meteor',file_rename)
      code, result, response = Qiniu::Storage.upload_with_put_policy(put_policy, locale_file)
      params[:av_lib][:av_poster] = "#{Settings.qiniu_cdn_host + file_rename}"
      Channel.clear_qiniu_cache(file_rename)
    end
    @av_lib = AvLib.new(av_lib_params)
    if @av_lib.save
      flash[:success] = "「#{@av_lib.av_title}」添加成功"
      redirect_to admin_av_libs_path
    else
      flash[:error] = "「#{@av_lib.av_title}」表单数据不完整"
      render :new
    end
  end

  def update
    if params[:av_lib][:photo_file].present?
      locale_file, file_rename = Channel.qiniu_cache_file(params[:av_lib][:photo_file])
      put_policy = Qiniu::Auth::PutPolicy.new('meteor',file_rename)
      code, result, response = Qiniu::Storage.upload_with_put_policy(put_policy, locale_file)
      params[:av_lib][:av_poster] = "#{Settings.qiniu_cdn_host + file_rename}"
      Channel.clear_qiniu_cache(file_rename)
    end
    if @av_lib.update(av_lib_params)
      flash[:success] = "「#{@av_lib.av_title}」添加成功"
      redirect_to admin_av_libs_path
    else
      flash[:error] = "「#{@av_lib.av_title}」表单数据不完整"
      render :edit
    end

  end

  def destroy
    @av_lib.destroy
    flash[:success] = "「#{@av_lib.av_title}」视频数据清除成功"
    redirect_to admin_av_libs_path
  end

  private
    def set_av_lib
      @av_lib = AvLib.find(params[:id])
    end

    def av_lib_params
      params.require(:av_lib).permit(:av_title, :av_type, :av_duration, :av_poster, :av_source, :av_introduction)
    end
end

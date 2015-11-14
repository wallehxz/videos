#coding: utf-8
class Admin::QiniuController < ApplicationController
  before_action :authenticate_admin!
  layout 'LTE_admin'

  def index
    @marker,@file_lists = Channel.qiniu_list(params[:mark],params[:prefix])
    if params[:mark].present?
      @old_marker = params[:mark]
    end
  end

  def new

  end

  def create
    if params[:file].present?
      locale_file, file_rename = Channel.qiniu_cache_file(params[:file])
      put_policy = Qiniu::Auth::PutPolicy.new('meteor',file_rename)
      code, result, response = Qiniu::Storage.upload_with_put_policy(put_policy, locale_file)
      Channel.clear_qiniu_cache(file_rename)
      flash[:success] = '文件已经上传到七牛云服务器'
      redirect_to "/admin/qiniu?prefix=#{result['key']}"
    else
      flash[:warn] = '您还没有选择上传文文件'
      render :new
    end
  end

  def edit
  end

  def update
    ext = (/.*(\/)(.*)/im.match params[:type])[2]
    if params[:new_name].split('.')[1].present?
      full_name = params[:new_name]
    else
      full_name = "#{params[:new_name]}.#{ext}"
    end
    code, result, response_headers = Qiniu::Storage.move(
        'meteor', params[:key], 'meteor', full_name
    )
    if code != 614
      flash[:success] = '恭喜！文件重命名成功'
      redirect_to "/admin/qiniu?prefix=#{params[:new_name]}"
    else
      flash[:warn] = '文件名已经被使用，请更换新的名称'
      redirect_to "/admin/qiniu/edit?key=#{params[:key]}&type=#{params[:type]}"
    end
  end

  def destroy
    code, result, response_headers = Qiniu::Storage.delete(
        'meteor', params[:key]
    )
    if code == 200
      flash[:success] = "恭喜！文件「#{params[:key]}」删除成功"
      redirect_to "/admin/qiniu?prefix=#{params[:prefix]}"
    else
      flash[:warn] = '文件删除失败，请重新操作'
      redirect_to "/admin/qiniu?prefix=#{params[:key]}"
    end
  end

end
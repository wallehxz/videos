#coding: utf-8
require 'base64'
require 'qiniu'
require 'digest'
class UserDetailsController < ApplicationController
  before_action :authenticate_user!

  def profile
    render layout: false
  end

  def profile_update
    detail = UserDetail.find_by_user_id(current_user.id)
    detail.nick_name = params[:user][:nick_name]
    detail.iphone = params[:user][:iphone]
    detail.qq = params[:user][:qq]
    detail.save
    render profile_user_details_path
  end

  def avatar

    render layout: false
  end

  def avatar_update
    qiniu_bucket = Settings.qiniu_cdn_host
    detail = UserDetail.find_by_user_id(current_user.id)
    data_url = params[:avatar]
    png = Base64.decode64(data_url['data:image/png;base64,'.length .. -1])
    dir_path = "#{Rails.root}/public/"
    file_rename = "#{Time.now.to_s}.png"
    File.open(dir_path+file_rename, 'wb') { |f| f.write(png) }
    put_policy = Qiniu::Auth::PutPolicy.new('meteor',"img_#{[*'a'..'z',*'0'..'9',*'A'..'Z'].sample(25).join}.png")
    local_file = "#{dir_path}/#{file_rename}"
    code, result, response_headers = Qiniu::Storage.upload_with_put_policy(put_policy, local_file)
    UserDetail.delete_picture file_rename
    detail.avatar = qiniu_bucket + result['key']
    detail.save
    redirect_to root_path
  end

end

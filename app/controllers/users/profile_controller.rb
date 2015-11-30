require 'base64'
require 'digest'
class Users::ProfileController < ApplicationController
  before_action :authenticate_user!

  def new_avatar
    render layout: false
  end

  def create_avatar
    file = Base64.decode64(params[:avatar]['data:image/png;base64,'.length .. -1])
    file_name = "img_#{Cattle.rand_string_name(20)}.png"
    file_path = "#{Rails.root}/public/uploads/#{file_name}"
    File.open(file_path,'wb+') do |item|
      item.write(file)
    end
    current_user.avatar = Cattle.upload_yun(file_name,file_path)
    current_user.save
    redirect_to root_path
  end

  def profile
    render layout: false
  end

  def update_profile
    current_user.nick_name = params[:nick_name]
    current_user.phone = params[:phone]
    current_user.save
    redirect_to profile_path
  end

end

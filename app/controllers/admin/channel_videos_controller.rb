#coding: utf-8
class Admin::ChannelVideosController < ApplicationController
  before_action :set_channel_video, only: [:show, :edit, :update, :destroy]
  before_filter :find_channel, :authenticate_admin!
  layout 'LTE_admin'

  def index
    redirect_to admin_released_path
  end

  def show
  end

  def new
    @channel
    @channel_video = ChannelVideo.new
  end

  def edit
  end

  def create
    if params[:channel_video][:is_recommend].to_i == 1
      if ChannelVideo.where(:channel_id => @channel.id).where(:is_recommend=> 1).count > 0
        old_recommend = ChannelVideo.where(:channel_id => @channel.id).where(:is_recommend=> 1).first
        old_recommend.is_recommend = 0
        old_recommend.save
      end
    end
    if params[:channel_video][:photo_file].present?
      locale_file, file_rename = Channel.qiniu_cache_file(params[:channel_video][:photo_file])
      put_policy = Qiniu::Auth::PutPolicy.new('meteor',file_rename)
      code, result, response = Qiniu::Storage.upload_with_put_policy(put_policy, locale_file)
      Channel.clear_qiniu_cache(file_rename)
      params[:channel_video][:video_cover] = "#{Settings.qiniu_cdn_host + file_rename}"
    end
    params[:channel_video][:channel_id] =@channel.id
    @channel_video = ChannelVideo.new(channel_video_params)
    if @channel_video.save
      youku_info = ChannelVideo.find(@channel_video.id)
      youku_info.youku_json = ChannelVideo.video_basic(@channel_video.youku_id)
      youku_info.save
      flash[:warn] = "「#{@channel_video.title}」视频添加成功！"
      redirect_to admin_channel_path(@channel)
    else
      flash[:error] = "「#{@channel_video.title}」表单数据不完整"
      render :new
    end
  end

  def update
    if params[:channel_video][:is_recommend].to_i == 1
      if ChannelVideo.where(:channel_id => @channel.id).where(:is_recommend=> 1).count > 0
        old_recommend = ChannelVideo.where(:channel_id => @channel.id).where(:is_recommend=> 1).first
        if old_recommend.id != @channel_video.id
          old_recommend.is_recommend = 0
          old_recommend.save
        end
      end
    end
    if params[:channel_video][:photo_file].present?
      locale_file, file_rename = Channel.qiniu_cache_file(params[:channel_video][:photo_file])
      put_policy = Qiniu::Auth::PutPolicy.new('meteor',file_rename)
      code, result, response = Qiniu::Storage.upload_with_put_policy(put_policy, locale_file)
      Channel.clear_qiniu_cache(file_rename)
      params[:channel_video][:video_cover] = "#{Settings.qiniu_cdn_host + file_rename}"
    end
    params[:channel_video][:youku_json]= ChannelVideo.video_basic(params[:channel_video][:youku_id])
    if @channel_video.update(channel_video_params)
      flash[:warn] = "「#{@channel_video.title}」视频内容更新成功！"
      redirect_to  admin_channel_path(@channel)
    else
      flash[:error] = "「#{@channel_video.title}」表单数据不完整"
      render :edit
    end
  end

  def destroy
    @channel_video.destroy
    flash[:notice] = "「#{@channel_video.title}」视频信息删除"
    redirect_to admin_channel_path(@channel)
  end

  def find_channel
    @channel = Channel.find_by_id(params[:channel_id])
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_channel_video
      @channel_video = ChannelVideo.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def channel_video_params
      params.require(:channel_video).permit(:channel_id, :is_recommend, :title, :content, :video_type, :youku_id, :video_cover,:youku_json)
    end
end

#coding: utf-8
require 'will_paginate'
class HomeController < ApplicationController
  before_action :view_user!, only: [:av_play, :av_channel]
	layout 'layout_krtvII'

  def index
    @videos = ChannelVideo.order(:id => :desc).limit(9)
  end

  def playing
    if ChannelVideo.find_by_youku_id(params[:youku_id])
      @video = ChannelVideo.find_by_youku_id(params[:youku_id])
      @comments = VideoComment.where(:channel_video_id => @video.id).order(:created_at=> :desc)
    else
      redirect_to root_path
    end
  end

  def channel
    if Channel.find_by_english(params[:english])
      @channel = Channel.find_by_english(params[:english])
      @channel_videos = ChannelVideo.
          where(:channel_id => @channel.id).
          order(:created_at=> :desc).
          paginate(:per_page=>9, :page=>params[:page])
    else
      redirect_to root_path
    end
  end

  def get_more
    @more_videos = ChannelVideo.order(:id => :desc).paginate(:per_page=>9, :page=>params[:page] || 1)
    @video_array = Array.new
    count = 0
    video_left = @more_videos.count - params[:page].to_i*9
    if video_left <= 0
      left = "+ _ "
    else
      left = video_left
    end
    @more_videos.each do |video|
      count +=1
      item_video ={video_id:video.id,youku_id:video.youku_id,image: video.video_cover,channel:"「#{Channel.find(video.channel_id).title}」",title:ChannelVideo.truncate_title(video.title),duration:ChannelVideo.video_time(video.youku_json[:duration]),time:video.created_at.strftime('%m/%d %H:%M')}
      @video_array.push(item_video)
    end
    video_json = {count:count,left:left, status:200, body:@video_array}
    render json: video_json
  end

  def get_channel_more
    @channel_videos = ChannelVideo.where(:channel_id=>params[:channel]).order(:id => :desc).paginate(:per_page=>9, :page=>params[:page] || 1)
    @channel_array = Array.new
    count = 0
    video_left = @channel_videos.count - params[:page].to_i*9
    if video_left <= 0
      left = "+ _ "
    else
      left = video_left
    end
    @channel_videos.each do |video|
      count +=1
      item_video ={video_id:video.id,youku_id:video.youku_id,image: video.video_cover,channel:"「#{Channel.find(video.channel_id).title}」",title:ChannelVideo.truncate_title(video.title),duration:ChannelVideo.video_time(video.youku_json[:duration]),time:video.created_at.strftime('%m/%d %H:%M')}
      @channel_array.push(item_video)
    end
    video_json = {count:count,left:left, status:200, body:@channel_array}
    render json: video_json
  end

  #XMTI5MDE1MjMyOA==
  def youku_play
    if params[:id].nil?
      redirect_to root_path
    else
      youku_id = params[:id].gsub('id_','')
      @info = ChannelVideo.video_basic(youku_id)
    end

  end

  def av_play
    @av = AvLib.find(params[:id])
  end

  def av_channel
    @avs = AvLib.order(:created_at=> :desc)
  end

end

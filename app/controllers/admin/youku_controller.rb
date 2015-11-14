#coding: utf-8
class Admin::YoukuController < ApplicationController
	skip_before_filter :verify_authenticity_token, :only => [:release_video]
	before_filter :authenticate_admin!
	layout 'LTE_admin'

	def index
		videos = ChannelVideo.user_video_all(params[:page])
		@count = videos['total']
		@total_pages = (videos['total'] - 1)/15 + 1
		@videos = videos['videos']
	end

	def upload
	end

	def release_video
		release = ChannelVideo.new
		release.channel_id = params[:channel_id].to_i
		release.is_recommend = 0
		release.youku_id = params[:youku_id]
		release.title = params[:title]
		release.content = params[:content]
		release.youku_json = ChannelVideo.video_basic(params[:youku_id])
		release.save
	end

end
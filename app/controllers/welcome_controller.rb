require 'will_paginate'
class WelcomeController < ApplicationController
  layout 'just_front'
  skip_before_filter :verify_authenticity_token, only: [:get_channel_more]

  def index
    @channel = Column.hexie.order(updated_at: :desc)
    @videos = Video.recent.hexie.paginate(:per_page=>9,:page=> 1)
  end

  def get_index_more
    @videos = Video.recent.hexie.paginate(:per_page=>9,:page=> params[:page])
    render :partial => 'shared/more_videos', layout: false
  end

  def channel
    if Column.find_by_english(params[:english])
      @channel = Column.find_by_english(params[:english])
      @videos = Video.recent.where(:column_id => @channel.id).paginate(:per_page=>9,:page=> 1)
    else
      redirect_to root_path
    end
  end

  def get_channel_more
    @videos = Video.recent.where(:column_id => params[:column]).paginate(:per_page=> 9,:page=> params[:page])
    render :partial => 'shared/more_videos', layout: false
  end

  def playing
    @video = Video.find_by_tv_code!(params[:tv_code])
  end

  def interim
    @video = Video.code_to_youku_info(params[:youku_url].gsub('id_',''))
  end

  def feed
    @videos = Video.recent.limit(20)
    render 'welcome/feed', layout: false
  end

end

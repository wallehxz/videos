require 'will_paginate'
class WelcomeController < ApplicationController
  layout 'just_front'
  skip_before_filter :verify_authenticity_token, only: [:get_channel_more]

  def index
    @channel = Column.hexie.shunxu
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
      if params[:english] =='Fucking'
        if current_user.present? && current_user.can_av?
          @channel;@videos
        else
          redirect_to root_path
        end
      else
        @channel;@videos
      end
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
    if Column.find_by_english(params[:english]) && params[:english] != 'Fucking'
      @column = Column.find_by_english(params[:english])
      if params[:all] == 'true'
        @videos = Video.recent.where(column_id:@column.id)
      else
        @videos = Video.recent.where(column_id:@column.id).limit(20)
      end
    else
      @videos = Video.hexie.recent.limit(20)
    end
    render 'welcome/feed', layout: false
  end

end

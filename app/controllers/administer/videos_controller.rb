class Administer::VideosController < ApplicationController
  layout 'just_admin'
  before_action :set_column, :authenticate_admin!
  before_action :set_video, only: [:show, :edit, :update, :destroy]

  def new
    @video = Video.new
  end

  def edit
  end

  def create
    param = params[:video]
    param[:column_id] = @column.id
    param[:cover] = Video.update_cover_to_video(param[:photo_file],param[:cover])
    param[:tv_code] = Video.type_url_to_code(param[:video_type],param[:tv_code])
    param[:duration] = Video.video_type_to_duration(param[:video_type],param[:tv_code],param[:duration])
    @video = Video.new(video_params)
    if @video.save
      redirect_to channel_path(@column.english)
    else
      render :new
    end
  end

  def update
    param = params[:video]
    param[:cover] = Video.update_cover_to_video(param[:photo_file],param[:cover])
    if @video.update(video_params)
      redirect_to channel_path(@column.english)
    else
      render :edit
    end
  end

  def destroy
    @video.destroy
    redirect_to channel_path(@column.english)
  end

  private
    def set_video
      @video = Video.find(params[:id])
    end

    def video_params
      params.require(:video).permit(:column_id, :tv_code, :recommend, :title, :cover, :duration, :video_type, :summary)
    end

    def set_column
      @column = Column.find(params[:column_id])
    end
end

require 'csv'
class Administer::ColumnsController < ApplicationController
  layout 'just_admin'
  before_action :authenticate_admin!
  before_action :set_column, only: [:show, :edit, :update, :destroy]
  before_action :set_param, only: [:create, :update]

  def index
    @columns = Column.latest.paginate(per_page:10, page:params[:page])
  end

  def show
  end

  def new
    @column = Column.new
  end

  def edit
  end

  def create
    @param[:cover] = Column.file_or_url(@param[:photo_file],@param[:cover])
    @column = Column.new(column_params)
    if @column.save
      redirect_to columns_path
    else
      render :new
    end

  end

  def update
    @param[:cover] = Column.file_or_url(@param[:photo_file], @param[:cover])
      if @column.update(column_params)
        redirect_to columns_path
      else
        render :edit
      end
  end

  def destroy
    @column.destroy
    redirect_to columns_path
  end

  def import_videos

  end

  def create_csv_data
    csv_text = params[:data_file].tempfile
    csv = CSV.parse(csv_text, :headers => true)
    csv.each do |item|
      data = Video.new
      data.column_id = params[:column_id]
      data.recommend = 0
      data.video_type = 0
      data.tv_code = item[2]
      data.title = item[1]
      data.cover = item[3]
      data.duration = Video.code_to_youku_info(item[2])['duration']
      data.save!
    end
    redirect_to channel_path(Column.find(params[:column_id]).english)
  end

  private
    def set_column
      @column = Column.find(params[:id])
    end

    def column_params
      params.require(:column).permit(:name, :english, :icon, :cover, :summary)
    end

    def set_param
      @param = params[:column]
    end
end

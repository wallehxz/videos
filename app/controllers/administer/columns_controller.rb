class Administer::ColumnsController < ApplicationController
  layout 'just_admin'
  before_action :authenticate_admin!
  before_action :set_column, only: [:show, :edit, :update, :destroy]

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
    params[:column][:cover] = Column.picture_url(params[:column][:photo_file])
    @column = Column.new(column_params)
    if @column.save
      redirect_to dashboard_path
    else
      render :new
    end

  end

  def update
      if params[:column][:photo_file].present?
        params[:column][:cover] = Column.picture_url(params[:column][:photo_file])
      end
      if @column.update(column_params)
        redirect_to dashboard_path
      else
        render :edit
      end
  end

  def destroy
    @column.destroy
    redirect_to dashboard_path
  end

  private
    def set_column
      @column = Column.find(params[:id])
    end

    def column_params
      params.require(:column).permit(:name, :english, :cover, :summary)
    end
end

class  Administer::DashboardController < ApplicationController
  before_action :authenticate_admin!
  layout 'just_admin'

  def index
  end

  def channel
    @column = Column.find_by_english(params[:english])
    @videos = Video.where(column_id: @column.id).recent.paginate(per_page:10,page:params[:page])
  end

end

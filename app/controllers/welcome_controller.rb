class WelcomeController < ApplicationController
  layout 'just_front'

  def index
    @column = Column.order(updated_at: :desc)
  end

  def playing

  end

  def interim_play
    @video = Video.code_to_youku_info(params[:youku_url].gsub('id_',''))
  end

end

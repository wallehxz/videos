class Administer::SevenCattleController < ApplicationController
  layout 'just_admin'
  before_action :authenticate_admin!

  def index
    @pre_page = params[:page]   if params[:page].present?
    @next_page,@files = Cattle.files_list(params[:prefix],params[:page])
  end

  def new

  end

  def create
    if params[:file].present?
      name,path = Cattle.local_cache_file(params[:file])
      Cattle.upload_yun(name,path)
      flash[:success] = '文件上传成功！'
      redirect_to "/zhang/files?prefix=#{name}"
    else
      flash[:warn] = '请选择上传文件！'
      render :new
    end
  end

  def edit
    @file = Cattle.file_to_info(params[:key])
  end

  def update
    ext = (/.*(\/)(.*)/im.match params[:type])[2]
    if params[:new].split('.')[1].present?
      full_name = params[:new]
    else
      full_name = "#{params[:new]}.#{ext}"
    end
    if Cattle.rename_yun_file_name(params[:old],full_name)
      flash[:success] = '文件重命名成功'
      redirect_to "/zhang/files?prefix=#{full_name}"
    else
      flash[:warn] = '文件名已经存在'
      redirect_to "/zhang/files/edit?key=#{params[:old]}"
    end

  end

  def destroy
     if Cattle.delete_yun_file(params[:key])
       flash[:success] = '文件删除成功'
       redirect_to files_path
     else
       flash[:error] = '文件删除失败'
       redirect_to files_path
     end
  end

end

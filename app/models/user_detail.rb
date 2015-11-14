#coding: utf-8
# t.integer  "user_id"
# t.string   "avatar"
# t.string   "nick_name"
# t.string   "iphone"
# t.datetime "created_at"
# t.datetime "updated_at"
# t.string   "qq",         limit: 225

class UserDetail < ActiveRecord::Base
  belongs_to :user

  def self.avatar_upload(file)  #上传文件到本地
    dir_path = "#{Rails.root}/public/images/avatar"
    if !File.exist?(dir_path)
      FileUtils.makedirs(dir_path)
    end
    file_rename = "img_#{[*'a'..'z',*'0'..'9',*'A'..'Z'].sample(20).join}#{File.extname(file.original_filename)}"
    file_path = "#{dir_path}/#{file_rename}"
    File.open(file_path,'wb+') do |item| #用二进制对文件进行写入
      item.write(file.read)
    end
    store_path = "/images/avatar/#{file_rename}"
    return store_path
  end

  def self.delete_picture(picture_path) #删除图片
    file_path = "#{Rails.root}/public/#{picture_path}"
    if File.exist?(file_path)
      File.delete(file_path)
    end
  end

  #UserDetail.youku_hot_comments('XMTM1NTM3NTI2OA==')
  def  self.youku_hot_comments(youku_id)  #优酷热评10条
    video_json = $youku_conn.get do |req|
      req.url '/v2/comments/hot/by_video.json'
      req.params['client_id'] = Settings.youku_client_id
      req.params['video_id'] = youku_id
      req.params['count'] = 10
    end
    if video_json.body.present? && JSON.parse(video_json.body)['total'].to_i > 0
      comments = JSON.parse(video_json.body)['comments']
    else
      comments = nil
    end
    return comments
  end


end

class Video < ActiveRecord::Base
  validates_uniqueness_of :title, :tv_code
  validates_presence_of :column_id, :title, :cover, :video_type
  belongs_to :column
  scope :latest, -> { order(updated_at: :desc) }
  scope :recent, ->{ order(created_at: :desc)}

  #根据code获取优酷的视频信息 Video.def self.code_to_youku_info
  #{"id"=>"XMTM5MDUyNDY2MA==", "title"=>"忽必烈的二次创业 148", "thumbnail"=>"http://r1.ykimg.com/05420408564D93596A0A4804DD28AA95", "thumbnail_v2"=>"http://r1.ykimg.com/05420408564D93596A0A4804DD28AA95", "duration"=>"3348.18", "comment_count"=>"894", "favorite_count"=>"0", "up_count"=>"3089", "down_count"=>"85", "published"=>"2015-11-19 17:45:00", "copyright_type"=>"original", "public_type"=>"all", "state"=>"normal", "streamtypes"=>["hd2", "flvhd", "hd", "3gphd", "mp5hd", "mp5hd2"], "operation_limit"=>[], "category"=>"资讯", "view_count"=>462533, "tags"=>"罗振宇,罗辑思维,忽必烈,挑战,元朝,繁荣", "paid"=>0, "link"=>"http://v.youku.com/v_show/id_XMTM5MDUyNDY2MA==.html", "player"=>"http://player.youku.com/player.php/sid/XMTM5MDUyNDY2MA==/partnerid/9f88fcd420d33601/v.swf", "user"=>{"id"=>"128391495", "name"=>"罗辑思维", "link"=>"http://i.youku.com/u/UNTEzNTY1OTgw"}}
  def self.code_to_youku_info(code)
    params = { video_id:code,client_id:Settings.youku_client_id}
    response = $youku_conn.get '/v2/videos/show_basic.json', params
    return JSON.parse(response.body)
  end

  #根据 code 获取视频的热点评论 Video.code_to_hot_comment
   def self.code_to_youku_hot_comment(code)
     params = {client_id: Settings.youku_client_id, video_id:code}
     response = $youku_conn.get '/v2/comments/hot/by_video.json', params
     return JSON.parse(response.body)['comments']
   end

  #截取特殊符号标题内容
  def self.truncate_title(string)
    symbol = ['」','】','》','}']
    symbol.each do |item_word|
      if string.include?(item_word)
        return (/.*(」|】|}|》)(.*)/im.match string)[2]
      end
    end
    string
  end

  #根据链接截取相应的code
  def self.youku_url_to_code(url)
    return (/id_(\w+=*)[\.]/im.match url)[1] if (/id_(\w+=*)[\.]/im.match url).present?
  end

  def self.tencent_url_to_code(url)
    return url
  end

  def self.iqiyi_url_to_code(url)
    return url
  end

  def self.qiniu_url_to_code(url)
    return (/_(\w+)[\.]/im.match url)[1] if (/com\/(\w+\.\w+)/im.match url).present?
  end

  #视频时长判断获取
  def self.video_type_to_duration(type,code,time)
    return code_to_youku_info(code)['duration'] if type.to_i == 0
    return time if type.to_i == 3
  end

  #视频的code根据类型判断生成
  #Video.type_to_tv_code
  def self.type_url_to_code(type,url)
    return youku_url_to_code(url)      if type.to_i == 0 && url.include?('id_')
    return tencent_url_to_code(url)  if type.to_i == 1 && url.include?('com')
    return iqiyi_url_to_code(url)        if type.to_i == 2 && url.include?('com')
    return qiniu_url_to_code(url)       if type.to_i == 3 && url.include?('com')
    return url
  end

  #视频头图判断更新
  def self.update_cover_to_video(file,url)
    return Cattle.cache_to_yun(file) if file.present?
    return url if file.nil?
  end

end

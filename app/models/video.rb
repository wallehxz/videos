# == Schema Information
#
# Table name: videos
#
#  id         :integer          not null, primary key
#  column_id  :integer
#  recommend  :integer          default("0")
#  video_type :integer
#  tv_code    :string           not null
#  title      :string
#  cover      :string
#  duration   :string
#  summary    :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Video < ActiveRecord::Base
  validates_uniqueness_of :title, :tv_code
  validates_presence_of :column_id, :title, :cover, :video_type, :duration, :tv_code
  belongs_to :column
  has_many :comments
  after_save :update_youku_comment
  scope :latest, -> {order(updated_at: :desc)}
  scope :recent, ->{order(created_at: :desc)}
  scope :hexie, ->{where('video_type != 3')}

  #根据code获取优酷的视频信息 Video.def self.code_to_youku_info
  #{"id"=>"XMTM5MDUyNDY2MA==", "title"=>"忽必烈的二次创业 148", "thumbnail"=>"http://r1.ykimg.com/05420408564D93596A0A4804DD28AA95", "thumbnail_v2"=>"http://r1.ykimg.com/05420408564D93596A0A4804DD28AA95", "duration"=>"3348.18", "comment_count"=>"894", "favorite_count"=>"0", "up_count"=>"3089", "down_count"=>"85", "published"=>"2015-11-19 17:45:00", "copyright_type"=>"original", "public_type"=>"all", "state"=>"normal", "streamtypes"=>["hd2", "flvhd", "hd", "3gphd", "mp5hd", "mp5hd2"], "operation_limit"=>[], "category"=>"资讯", "view_count"=>462533, "tags"=>"罗振宇,罗辑思维,忽必烈,挑战,元朝,繁荣", "paid"=>0, "link"=>"http://v.youku.com/v_show/id_XMTM5MDUyNDY2MA==.html", "player"=>"http://player.youku.com/player.php/sid/XMTM5MDUyNDY2MA==/partnerid/9f88fcd420d33601/v.swf", "user"=>{"id"=>"128391495", "name"=>"罗辑思维", "link"=>"http://i.youku.com/u/UNTEzNTY1OTgw"}}
  # Video.code_to_youku_info('XMTM5MDUyNDY2MA==')
  def self.code_to_youku_info(code)
    params = { video_id:code,client_id:Settings.youku_client_id}
    response = $youku_conn.get '/v2/videos/show_basic.json', params
    return JSON.parse(response.body)
  end

  #根据 code 获取视频的热点评论 Video.code_to_hot_comment
   def self.code_to_youku_hot_comment(code,count)
     params = {client_id: Settings.youku_client_id, video_id:code, count:count}
     response = $youku_conn.get '/v2/comments/hot/by_video.json', params
     return JSON.parse(response.body)['comments']
   end

  def self.code_to_youku_comment(code,count)
    params = {client_id: Settings.youku_client_id, video_id:code, count:count}
    response = $youku_conn.get '/v2/comments/by_video.json', params
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
    return (/qq.com\/([\w,\/]+)[\.]/im.match url)[1] if (/qq.com\/([\w,\/]+)[\.]/im.match url).present?
  end

  def self.iqiyi_url_to_code(url)
    return (/v_(\w+=*)[\.]/im.match url)[1] if (/v_(\w+=*)[\.]/im.match url).present?
  end

  def self.qiniu_url_to_code(url)
    return (/_(\w+)[\.]/im.match url)[1] if (/com\/(\w+\.\w+)/im.match url).present?
  end

  #视频时长判断获取
  def self.video_type_to_duration(type,code,time)
    return code_to_youku_info(code)['duration'] if type.to_i == 0
    return time if type.to_i != 0
  end

  #视频的code根据类型判断生成
  #Video.type_to_tv_code
  def self.type_url_to_code(type,url)
    return youku_url_to_code(url) if type.to_i == 0 && url.include?('.youku.com')
    return tencent_url_to_code(url) if type.to_i == 1 && url.include?('.qq.com')
    return iqiyi_url_to_code(url) if type.to_i == 2 && url.include?('.iqiyi.com')
    return qiniu_url_to_code(url) if type.to_i == 3 && url.include?('com')
    return url
  end

  #视频头图判断更新
  def self.file_or_url_to_cover(file,url)
    return Cattle.cache_to_yun(file) if file.present?
    return url if file.nil?
  end

  def update_youku_comment
    if self.video_type == 0 && self.comments.count < 10
      ykh_com = Video.code_to_youku_hot_comment(self.tv_code,10)
      if ykh_com.length > 0
        ykh_com.each do |com|
          Comment.create(user_id:User.all.map(&:id).sample(1)[0],video_id:self.id,vote:rand(99) + 1,content:com['content'])
        end
      end
      if ykh_com.length < 10
        yk_com = Video.code_to_youku_comment(self.tv_code,10 - ykh_com.length)
        if yk_com.length > 0
          yk_com.each do |com|
            Comment.create(user_id:User.all.map(&:id).sample(1)[0],video_id:self.id,vote:rand(99) + 1,content:com['content'])
          end
        end
      end
      puts "#{self.title}更新评论#{self.comments.count}条"
    end
  end

end

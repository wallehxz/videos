#coding: utf-8
# t.integer  "channel_id"
# t.integer  "is_recommend", default: 0
# t.string   "video_cover"
# t.string   "title"
# t.integer  "video_type",   default: 0
# t.text     "content"
# t.string   "youku_id"
# t.text     "youku_json"
# t.datetime "created_at"
# t.datetime "updated_at"

class ChannelVideo < ActiveRecord::Base
  belongs_to :channel
  validates_uniqueness_of :youku_id
  validates_presence_of :title, :youku_id, :channel_id
  store :youku_json, coder: JSON

  #单条视频基本信息
  def self.video_basic(youku_id)

    video_json = $youku_conn.get do |req|
      req.url '/v2/videos/show_basic.json'
      req.params['video_id'] = youku_id
      req.params['client_id'] = Settings.youku_client_id
    end
    JSON.parse(video_json.body)
  end

  #单条视频详细信息
  def self.video_info(youku_id)

    video_json = $youku_conn.get do |req|
      req.url '/v2/videos/show.json'
      req.params['video_id'] = youku_id
      req.params['client_id'] = Settings.youku_client_id
    end
    JSON.parse(video_json.body)
  end

  #ChannelVideo.user_video_all(1)
  #用户上传的所有视频
  def self.user_video_all(page)

    video = $youku_conn.get do |req|
      req.url '/v2/videos/by_user.json'
      req.params['client_id'] = Settings.youku_client_id
      req.params['user_id'] = Settings.youku_user_id
      req.params['orderby'] ='published'
      req.params['page'] = page
      req.params['count'] = 15
    end
    if video.status == 200
      JSON.parse(video.body)
    else
      '用户视频不存在'
    end
  end

  #优酷视频标题截取符号
  def self.truncate_title(string)

    word = ['」','】','》','}']
    word.each do |item_word|
       if string.include?(item_word)
         return (/.*(」|】|}|》)(.*)/im.match string)[2]
       end
    end
    string
  end

  # .gsub('x2015.b0.upaiyun.com','images.36kr.com')替换图片链接

  def self.video_time(time)

    if time.to_i >= 60
      return "#{time.to_i / 60} 分钟"
    else
      return "#{time.to_i} 秒"
    end
  end

end

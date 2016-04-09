#coding: utf-8
module ApplicationHelper

  def video_time(time)
    if time.to_i >= 60
      return "#{time.to_i / 60} 分钟"
    else
      return "#{time.to_i} 秒"
    end
  end

  def symbol_truncate(string)
    symbol = ['」','】','》','}']
    symbol.each do |item|
      if string.to_s.include?(item)
        return (/.*(」|】|}|》)(.*)/im.match string)[2] if (/.*(」|】|}|》)(.*)/im.match string).present?
      end
    end
    return string
  end

  def rank_picture(user)
    num = user.sign_in_count
    if num < 3
      return image_path('rank/rank-1.png')
    elsif num >= 3 && num < 7
      return image_path('rank/rank-2.png')
    elsif num >= 7 && num < 12
      return image_path('rank/rank-3.png')
    elsif num >= 12 && num < 20
      return image_path('rank/rank-4.png')
    elsif num >= 20 && num < 30
      return image_path('rank/rank-5.png')
    elsif num >= 30 && num < 50
      return image_path('rank/rank-6.png')
    elsif num >= 50
      return image_path('rank/rank-7.png')
    end
  end

  def rand_rank_picture(num)
    if num < 3
      return image_path('rank/rank-1.png')
    elsif num >= 3 && num < 7
      return image_path('rank/rank-2.png')
    elsif num >= 7 && num < 12
      return image_path('rank/rank-3.png')
    elsif num >= 12 && num < 20
      return image_path('rank/rank-4.png')
    elsif num >= 20 && num < 30
      return image_path('rank/rank-5.png')
    elsif num >= 30 && num < 50
      return image_path('rank/rank-6.png')
    elsif num >= 50
      return image_path('rank/rank-7.png')
    end
  end

  def rank_name(user)
    num = user.sign_in_count
    if num < 3
      return '「英勇黄铜」'
    elsif num >= 3 && num < 7
      return '「不屈白银」'
    elsif num >= 7 && num < 12
      return '「荣耀黄金」'
    elsif num >= 12 && num < 20
      return '「华贵铂金」'
    elsif num >= 20 && num < 30
      return '「璀璨钻石」'
    elsif num >= 30 && num < 50
      return '「超凡大师」'
    elsif num >= 50
      return '「最强王者」'
    end
  end

  def rand_rank_name(num)
    if num < 3
      return '「英勇黄铜」'
    elsif num >= 3 && num < 7
      return '「不屈白银」'
    elsif num >= 7 && num < 12
      return '「荣耀黄金」'
    elsif num >= 12 && num < 20
      return '「华贵铂金」'
    elsif num >= 20 && num < 30
      return '「璀璨钻石」'
    elsif num >= 30 && num < 50
      return '「超凡大师」'
    elsif num >= 50
      return '「最强王者」'
    end
  end

  def rand_lol_picture(num)
    return image_path("lol/#{num}.jpg")
  end

  def rand_lol_name(num)
    return Comment::Name[num]
  end

  #根据视频类型返回相应的播放链接
  def code_type_to_url(code,type)
    return "http://v.youku.com/v_show/id_#{code}.html"if type.to_i == 0 #优酷视频
    return "http://v.qq.com/#{code}.html" if type.to_i == 1 #腾讯视频
    return "http://www.iqiyi.com/v_#{code}.html" if type.to_i == 2 #爱奇艺视频
    return "#{Settings.qiniu_cdn_host}vcd_#{code}.mp4"if type.to_i == 3 #七牛源文件
  end

  #通过视频的频道编号返回其中文名称
  def video_to_column_name(video)
    Column.find(video).name
  end

  def video_to_column_icon(video)
    Column.find(video).icon
  end

  def display_name(user)
    return user.nick_name if user.nick_name.present?
    return user.email if user.nick_name.nil?
  end

  def display_avatar(user)
    return user.avatar if user.avatar.present?
    return rand_lol_picture(rand(77)) if user.avatar.nil?
  end

  def display_role(user)
    return '苦逼管理员' if user.role=='admin'
    return '荒野大嫖客' if user.role=='fucker'
    return '文艺小骚年' if user.role=='looker'
  end

  def display_video_type(video)
    return '优酷视频' if video.video_type == 0
    return '腾讯视频' if video.video_type == 1
    return '爱奇艺视频' if video.video_type == 2
    return '爱情动作片' if video.video_type == 3
  end

  def column_video_or_recommend(column)
    recommend = Video.recent.where(:column_id=>column).where(:recommend=> 1).first
    video = Video.recent.where(:column_id=>column).where(:recommend=> 0).first
    return video_playing_path recommend.tv_code if recommend.present?
    return video_playing_path video.tv_code if video.present?
  end

  def video_cover(url)
    return "#{url}!300x160" if url.include?(Settings.qiniu_cdn_host)
    url
  end

  def carousel_cover(url)
    return "#{url}!960x420" if url.include?(Settings.qiniu_cdn_host)
    url
  end

  def carousel_avatar_cover(url)
    return "#{url}!100x100" if url.include?(Settings.qiniu_cdn_host)
    url
  end

  def list_cover(url)
    return "#{url}!300x150" if url.include?(Settings.qiniu_cdn_host)
    url
  end

end

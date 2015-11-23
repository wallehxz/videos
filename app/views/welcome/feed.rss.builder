xml.instruct! :xml, :version => '1.0'
xml.rss :version => '2.0' do
  cache [ :video, @videos.first.created_at ] do
    xml.channel do
      xml.title '华轩·张'
      xml.link 'http://huaxuan.link'
      xml.language 'zh-CN'
      xml.description '好看好玩的视频'

      for video in @videos
        xml.item do
          xml.title video.title
          xml.category video_to_column_name(video.column_id)
          xml.link "http://huaxuan.link" + playing_path(video.tv_code)
          xml.source code_type_to_url(video.tv_code,video.video_type)
          xml.image video.cover
          xml.pubDate video.created_at.to_s(:rfc822)
        end
      end
    end
  end
end
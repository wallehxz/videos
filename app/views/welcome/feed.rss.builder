xml.instruct! :xml, :version => '1.0'
xml.rss :version => '2.0' do
  cache [ :video, params[:english], @videos.map{|v| v.updated_at}.max ] do
    xml.channel do
      xml.title '华轩·张'
      xml.language 'zh-CN'
      xml.link 'http://huaxuan.link'
      xml.description '在沉默中爆发'
      xml.total @videos.count

      for video in @videos
        xml.item do
          xml.channel video_to_column_name(video.column_id)
          xml.title video.title
          xml.youkuid video.tv_code
          xml.url "http://huaxuan.link" + video_playing_path(video.tv_code)
          xml.picture video.cover
          xml.source code_type_to_url(video.tv_code,video.video_type)
          xml.description do
            xml.cdata! video.summary ? video.summary : '暂无简介'
          end
          xml.pubDate video.created_at.to_s(:rfc822)
        end
      end
    end
  end
end
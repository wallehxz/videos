class Api::WeChatController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def echo_get_msg
    render :text => params[:echostr]
  end

  def echo_post_msg
    @request = Hash.from_xml(request.body.read)['xml']
    if @request['EventKey'].present?
      @videos = send_video(@request['EventKey'],3)
      render 'api/we_chat/echo_video', :formats => :xml
    elsif @request['MsgType'] == 'text'
      if msg_rand_send_video(@request['Content'],3).present?
        @videos = msg_rand_send_video(@request['Content'],3)
        render 'api/we_chat/echo_video', :formats => :xml
      else
        @msg = '你要和我说话？你真的要和我说话？你确定自己想说吗？你一定非说不可吗？那你说吧！'
        render 'api/we_chat/echo_string', :formats => :xml
      end
    end
  end

  def send_video(event,num)
    Video.find_by_sql("select * from videos where (column_id = #{key_to_column(event)}) order by random() limit #{num}")
  end

  def key_to_column(key)
    column = { 'dzjj'=> 1, 'ljsw'=>3, 'bzsj'=>4, 'kjwl'=> 6,'dytt'=> 5}
    return column[key]
  end

  def msg_rand_send_video(msg,num)
    Video.find_by_sql("select * from videos where( title like '%#{msg}%') and video_type != 3 order by random() limit #{num}")
  end

end

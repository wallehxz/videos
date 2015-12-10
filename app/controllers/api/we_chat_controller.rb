class Api::WeChatController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def echo_get_msg
    render :text => params[:echostr]
  end

  def echo_post_msg

  end

end

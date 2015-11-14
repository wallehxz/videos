#coding: utf-8
class VideoCommentsController < ApplicationController

  def anonymous_comment  #看客匿名评论
    anonymous = VideoComment.new
    anonymous.channel_video_id = params[:comment][:video_id]
    anonymous.user_id = 0
    anonymous.content = params[:comment][:content]
    anonymous.vote_count = 1
    anonymous.save
    render json: {status:200}
  end

  def user_comment #用户登陆评论
    user = VideoComment.new
    user.channel_video_id = params[:comment][:video_id]
    user.user_id = params[:comment][:user_id]
    user.reply_id = params[:comment][:reply_id]
    user.content = params[:comment][:content]
    user.vote_count = 1
    user.save
    render json: {status:200}
  end

  def comment_vote  #评论点赞
    comment = VideoComment.find_by_id(params[:comment][:comment_id])
    comment.vote_count = comment.vote_count + 1
    comment.save
    render json: {status:200}
  end

  def destroy_comment #用户删除自己的评论

  end

end

class CommentsController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def create
    @comment = Comment.new
    @comment.video_id = params[:comment][:video_id]
    @comment.user_id = params[:comment][:user_id]
    @comment.reply_id = params[:comment][:reply_id]
    @comment.content = params[:comment][:content]
    @comment.vote = 1
    @comment.save
    render partial: 'shared/user_release_comment', layout: false
  end

  def vote
    comment = Comment.find(params[:id])
    comment.vote = comment.vote + 1
    comment.save
    render text: comment.vote
  end

end

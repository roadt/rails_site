class CommentsController < ApplicationController
  authorize_resource

  def create 
    @post = Post.find(params[:post_id])
    @comment = @post.comments.new(params[:comment])
    @comment.owner = current_user
    @comment.save!
    redirect_to post_path(@post)
  end

  def destroy
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])
    @comment.destroy
    redirect_to post_path(@post)
  end
end

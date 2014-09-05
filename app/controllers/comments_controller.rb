class CommentsController < ApplicationController

  before_action :require_user
  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(params.require(:comment).permit(:body))
    @comment.creator = current_user
    @post.reload
    if @comment.save
      flash[:notice]= 'You comment was added.'
      redirect_to posts_path(@post)
    else

      render '/posts/show'
    end
  end
  def vote
    comment = Comment.find(params[:id])
    @vote =Vote.create(voteable:comment, creator:current_user,vote:params[:vote])
    if !@vote.errors.any?
      flash[:notice]= "You vote was counted."
    else
      flash[:notice]= "You can vote for comment once .".html_safe
    end
    redirect_to :back
  end
end


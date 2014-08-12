class CommentsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(params.require(:comment).permit(:body))
    @comment.creator = User.first # TODO: change once I have authentication
    if @comment.save
      flash[:notice]= 'You comment was added.'
      redirect_to posts_path(@post)
    else
      render '/posts/show'
    end
  end

end


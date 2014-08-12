class PostsController < ApplicationController

  before_action :set_post, only: [:show, :edit, :update]

  def index
    @posts = Post.all
  end

  def show
    @comment = Comment.new
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.creator = User.first # TODO: change once I have authentication
    if @post.save
      flash[:notice]="The new post was created."
      redirect_to posts_path
    else
      render  :new
    end

  end

  def edit; end

  def update

    if @post.update(post_params)
      flash[:notice]= "This post was updated."
      redirect_to post_path(@post)
    else
      render :edit
    end
  end

  def post_params
    params.require(:post).permit(:title, :url, :description, category_ids:[])

  end

  def set_post
    @post = Post.find(params[:id])

  end
end
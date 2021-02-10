class PostsController < ApplicationController
  before_action :authenticate_user!

  def index
    @posts = Post.all
    @tags = Post.tag_counts_on(:tags).order('count DESC')
    if @tag = params[:tag_name]   # タグ検索用
       @posts = Post.tagged_with(params[:tag_name])   # タグに紐付く投稿
    end
  end

  def search
    @posts = Post.search(params[:search])
    @value = params[:search]
  end

  def show
    @post = Post.find(params[:id])
    @user = @post.user
    @favorite = Favorite.new
    @comments = @post.comments
    @comment = current_user.comments.new
    if @tag = params[:tag]
      @post = Post.tagged_with(params[:tag])
    end
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      redirect_to post_path(@post)
    else
      render "new"
    end
  end

  def edit
    @post = Post.find(params[:id])
    if  @post.user == current_user
      render "edit"
    else
      redirect_to posts_path
    end
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to post_path(@post)
    else
      render :edit
    end
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
    redirect_to posts_path(post.user)
  end

  private
  def post_params
    params.require(:post).permit(:title, :body, :image, :tag_list)
  end
end

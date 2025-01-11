class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]

  def index
    @posts = current_user.feed
    @post = Post.new
    @user = current_user
  end

  def show
    @post = Post.find(params[:id])
    @new_post = Post.new
    @user = @post.user
  end

  def create
    @post = current_user.posts.new(post_params)
    if @post.save
      flash[:notice] = "投稿が保存されました。"
      redirect_to post_path(@post)
    else
     flash[:alert] = "投稿の保存に失敗しました。"
      @posts = Post.all
      @user = current_user
      render :index
    end
  end

  def edit
    @post = Post.find(params[:id])
    if @post.user !=current_user
     flash[:alert] = "編集する権限がありません。"
    redirect_to posts_path 
  end
end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      flash[:notice] = "投稿が更新されました。"
      redirect_to post_path(@post)
    else
      flash[:alert] = "投稿の更新に失敗しました。"
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])
    if @post.user == current_user
      @post.destroy
      flash[:notice] = "投稿が削除されました。"
    else
      flash[:alert] = "ユーザーの削除に失敗しました"
    end
    redirect_to posts_path
  end

  private

  def post_params
    params.require(:post).permit(:title, :content)
  end

  def ensure_correct_user
    @post = Post.find(params[:id])
    unless @post.user == current_user
      flash[:alert] = "権限がありません。"
      redirect_to posts_path
    end
  end
end


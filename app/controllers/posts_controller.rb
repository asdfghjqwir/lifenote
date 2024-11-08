class PostsController < ApplicationController
  before_action :authenticate_user!
   before_action :ensure_correct_user, only: [:edit, :update, :destroy]
  
  
  def index
    @posts=Post.all
    @post=Post.new
    @user=current_user
  end
  

  def show
    @post=Post.find(params[:id])
    @new_post=Post.new
    @user=@post.user
  end
  
  
  def create
    @post=current_user.posts.new(post_params)
    if @post.save
      flash[:notice] = "投稿が保存されました。"
      redirect_to post_path(@post) 
    else
    @posts=Post.all
    @user=current_user
      render :index
    end
  end
  
  

  def edit
    @post=Post.find(params[:id])
    redirect_to posts_path unless @post.user==current_user
  end


  def update
    @post=Post.find(params[:id])
    if @post.update(post_params)
      flash[:notice] = "投稿が更新されました。"
  redirect_to post_path(@post)
else
  render :edit
end
end
  
  def destroy
    @post=Post.find(params[:id])
   if @post.user==current_user
     @post.destroy
 flash[:notice] = "投稿が削除されました。"
  end
  redirect_to posts_path
end
   
  
  
  
  private
  
  def post_params
    params.require(:post).permit(:title,:content)
end

def ensure_correct_user
  @post=Post.find(params[:id])
  unless @post.user==current_user
    redirect_to posts_path
  end
end
end

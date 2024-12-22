class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]

  def index
    @users = User.all
    @user = current_user
    @post = Post.new
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts
    @post = Post.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "プロフィールが更新されました。"
      redirect_to user_path(@user)
    else
      flash[:alert] = "プロフィールの更新に失敗しました。"
      render :edit
    end
  end

  def destroy
    @user = User.find(params[:id])
    if @user == current_user
     if @user.destroy
        flash[:notice] = "アカウントが削除されました。"
        redirect_to root_path
    else
        flash[:alert] = "アカウントの削除に失敗しました。"
        redirect_to user_path(current_user)
    end
  else
    flash[:alert] = "他のユーザーの削除は許可されていません。"
    redirect_to user_path(current_user)
  end
end

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user == current_user || current_user.admin?
      flash[:alert] = "他のユーザーの操作は許可されていません。"
      redirect_to user_path(current_user)
    end
  end
end





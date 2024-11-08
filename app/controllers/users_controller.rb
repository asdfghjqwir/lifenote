class UsersController < ApplicationController
 before_action :authenticate_user!
 before_action :ensure_correct_user, only: [:edit,:update,:destroy]
 

def index
  @users=User.all
  @user=current_user
  @post=Post.new
end

  def show
    @user=User.find(params[:id])
    @posts=@user.posts
    @post=Post.new
  end

  def edit
    @user=User.find(params[:id])
  end

  def update
      @user=User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "プロフィールが更新されました。"
      redirect_to user_path(@user)
    else
      render :edit
    end
  end

 def destroy
   @user=User.find(params[:id])
   if @user==current_user
      @user.destroy
     flash[:notice] = "アカウントが削除されました。"
   end
     redirect_to new_user_registration_path
  end
 end
  
 private
 
 def user_params
 params.require(:user).permit(:name,:introduction,:profile_image)
 end
 
 
 def ensure_correct_user
   @user=User.find(params[:id])
   unless @user==current_user
   redirect_to user_path(current_user)
 end
 end

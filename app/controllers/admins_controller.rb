class AdminsController < ApplicationController
  before_action :authenticate_admin!

  def dashboard
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def destroy
    @user = User.find(params[:id])
    if @user.destroy
      flash[:notice] = "ユーザーを削除しました."
    else
      flash[:alert] = "ユーザーの削除に失敗しました."
    redirect_to admin_dashboard_path
  end
end

  private

  def authenticate_admin!
    unless session[:admin_id] && Admin.find_by(id: session[:admin_id])
      flash[:alert] = "管理者としてログインしてください."
      redirect_to admin_login_path
    end
  end
end

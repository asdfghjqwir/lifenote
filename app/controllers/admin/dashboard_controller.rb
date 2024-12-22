module Admin
class DashboardController < ApplicationController

  before_action :authenticate_admin_user!

  def index
    @users = User.all
  end


  def show
    @user = User.find(params[:id])
  end

  def destroy
    @user = User.find(params[:id])
    if current_admin_user.admin?
      if @user.destroy
        flash[:notice] = "ユーザーを削除しました。"
      else
        flash[:alert] = "ユーザーの削除に失敗しました。"
      end
    else
      flash[:alert] = "管理者以外は削除できません。"
    end
    redirect_to admin_dashboard_index_path
  end
end

end
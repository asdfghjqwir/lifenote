class AdminSessionsController < ApplicationController
  def new
  end

  def create
    admin = Admin.find_by(email: params[:email])
    if admin&.authenticate(params[:password])
      session[:admin_id] = admin.id
      flash[:notice] = "ログインしました。"
      redirect_to admin_dashboard_path
    else
      flash.now[:alert] = "ログインに失敗しました。"
      render :new
    end
  end

  def destroy
    session[:admin_id] = nil
    flash[:notice] = "ログアウトしました。"
    redirect_to admin_login_path
  end
end


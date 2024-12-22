class ApplicationController < ActionController::Base
  before_action :authenticate_user!, except: [:top, :about]
  before_action :configure_permitted_parameters, if: :devise_controller?


  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :email])
  end

  def after_sign_in_path_for(resource)
    if resource.is_a?(AdminUser) 
      admin_dashboard_index_path
    else
      root_path
    end
  end


  def after_sign_out_path_for(resource_or_scope)
    if resource_or_scope == :admin_user
      new_admin_user_session_path 
    else
      root_path 
    end
  end

end
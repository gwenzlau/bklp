class ApplicationController < ActionController::Base
  include PublicActivity::StoreController
  
  protect_from_forgery
  
  before_filter :configure_permitted_parameters, if: :devise_controller?
  
  protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.for(:sign_up) do |u|
        u.permit(:name, :email, :password, :password_confirmation)
      end
      devise_parameter_sanitizer.for(:account_update) do |u|
        u.permit(:name, :email, :avatar, :avatar_file_name, :avatar_content_type, :avatar_file_size, :avatar_updated_at, :password, :password_confirmation, :current_password)
      end
    end
end

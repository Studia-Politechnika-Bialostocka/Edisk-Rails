class ApplicationController < ActionController::Base
  after_action :is_there_base_directory2?

  def is_there_base_directory2?
    if user_signed_in?
      if !EdiskDirectory.where(user_id: current_user.id).exists?(name: "home", ancestry: nil)
        current_user.edisk_directories.create(name:"home", ancestry: nil)
      end
    end
  end

  respond_to :html, :json


  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:username, :email, :password)}

    devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:username, :email, :password, :current_password)}
  end

end

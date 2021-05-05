class ApplicationController < ActionController::Base
  before_action :is_there_base_directory?
  def is_there_base_directory?
    if EdiskDirectory.all.empty? ||EdiskDirectory.exists?(0)
      EdiskDirectory.create(id: 0, name: "home", path:"/")
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

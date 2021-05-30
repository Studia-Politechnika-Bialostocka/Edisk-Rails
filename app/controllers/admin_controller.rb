class AdminController < ApplicationController
  def dashboard
    if current_user.try(:admin?)
      @users = User.all
      @totalUsers = User.all.count
      @totalDiskUsage = 0
      for x in @users do
        @totalDiskUsage += x.current_size
      end

    elsif user_signed_in?
      redirect_to root_path, alert: "You don't have access!"
    else
      redirect_to new_user_session_path, notice: "Log in first"
    end
  end

  def destroy
    @user = User.find(params[:id])
    @tempUsername = @user.username
    @user.destroy
    redirect_to admin_dashboard_path, notice: "User #{@tempUsername}  deleted"
  end
end
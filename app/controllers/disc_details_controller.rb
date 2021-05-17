class DiscDetailsController < ApplicationController
  respond_to :html, :json

  before_action :authenticate_user!

  @users = User.all

  def general_details
    @who_am_i = current_user.username
    @curr_user = User.find_by(username: @who_am_i)

    @mini_root = edisk_directory_path(EdiskDirectory.where(user_id: current_user.id).find_by(name: "home", ancestry: nil))

    @acc_creation_date = @curr_user.created_at
    if !@curr_user.locked_at.nil?
      @acc_status = 'blocked at ' + @curr_iser.locked_at.to_s
    elsif @curr_user.confirmed_at.nil?
      @acc_status = 'unconfirment'
    else
      @acc_status = 'confirment at ' + @curr_user.confirmed_at.to_s
    end

    @acc_file_count = EdiskFile.where(userID: current_user.id).count

    @acc_last_act_date = @curr_user.updated_at

    @disc_max_usage =  @curr_user.ediskSize
    @disc_curr_usage = @curr_user.current_size

     respond_to do |format|
       format.html
     end
  end



  private
  def edisk_directory_params
    params.require(:edisk_directory).permit( :name,:parent_id, :ancestry)
  end
end

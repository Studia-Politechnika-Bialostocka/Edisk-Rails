class DiscDetailsController < ApplicationController
  respond_to :html, :json
  @acc_creation_date
  @acc_status
  @acc_file_count
  @acc_last_act_date
  @acc_last_act_type
  @disc_max_usage
  @disc_curr_usage

  @users = User.all

  def general_details
    @who_am_i = current_user.username
    @curr_user = User.find_by(username: @who_am_i)

    @acc_creation_date = @curr_user.created_at
    if !@curr_user.locked_at.nil?
      @acc_status = 'blocked at ' + @curr_iser.locked_at.to_s
    elsif @curr_user.confirmed_at.nil?
      @acc_status = 'unconfirment'
    else
      @acc_status = 'confirment at ' + @curr_user.confirmed_at.to_s
    end

    @acc_file_count = file_count

    @acc_last_act_date = @curr_user.updated_at

    @acc_last_act_type = activity_type
    @disc_max_usage =  max_usage
    @disc_curr_usage = current_usage

     respond_to do |format|
       format.html
     end
  end

  def current_usage
    1
  end

  def file_count
    0
  end

  def max_usage
    10
  end

  def activity_type
    "unknown"
  end
end

class DiscDetailsController < ApplicationController
  respond_to :html, :json
  @acc_creation_date
  @acc_status
  @acc_file_count
  @acc_last_act_date
  @acc_last_act_type
  @disc_max_usage
  @disc_curr_usage

  def sample_value
    @acc_creation_date = "data_kreacji_konta"
    @acc_status = "status konta"
    @acc_file_count = 0
    @acc_last_act_date = "data ostaniej aktywnosci"
    @acc_last_act_type = "typ ostatniej aktywnosci"
    @disc_max_usage = "10MB"
    @disc_curr_usage = "1MB"
  end

  def general_details
    sample_value
    render "disk_details/general_details"
  end
end

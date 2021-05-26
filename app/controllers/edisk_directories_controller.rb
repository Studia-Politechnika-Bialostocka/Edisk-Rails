class EdiskDirectoriesController < ApplicationController
  before_action :authenticate_user!
  # rescue_from ::ActiveRecord::RecordNotFound, with: :record_not_found
  helper_method :return_all_files_from_directory, :expiration_time_into_string

  after_action :count_Size_for_user

  #wrzutka testowa
  before_action :set_breadcrumbs

  def new
    @query = params[:format]
    @edisk_directory = EdiskDirectory.new
  end

  def create
    @query = params[:format]
    @edisk_directory = current_user.edisk_directories.children_of(params[:parent_id]).new(edisk_directory_params)
    actual_dir = EdiskDirectory.where(user_id: current_user.id).find(@edisk_directory.parent_id)
    if @edisk_directory.save
      redirect_to edisk_directory_path(actual_dir)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @edisk_directory = EdiskDirectory.where(user_id: current_user.id).find(params[:id])
  end

  def update
      @edisk_directory = EdiskDirectory.where(user_id: current_user.id).find(params[:id])
      actual_dir = EdiskDirectory.where(user_id: current_user.id).find(@edisk_directory.parent_id)

      if @edisk_directory.update(edisk_directory_params)
        redirect_to edisk_directory_path(actual_dir)
      else
        render :edit, status: :unprocessable_entity
      end
  end
  def destroy
    @edisk_directory = EdiskDirectory.where(user_id: current_user.id).find(params[:id])
    actual_dir = @edisk_directory.parent_id
    @edisk_directory.destroy

    redirect_to edisk_directory_path(actual_dir), notice: "Sucesfully destroyed"
  end

  def show
    @edisk_directory = EdiskDirectory.find(params[:id])
    @edisk_directories = EdiskDirectory.children_of(@edisk_directory).where(user_id: current_user.id)

    #wrztuka
    @curr_path
    @rev_bread = ""
    @mini_root = @edisk_directory
    while !@mini_root.parent_id.nil? do
      @rev_bread = @mini_root.name + @rev_bread
      @rev_bread = "/" + @rev_bread
      @mini_root = @mini_root.parent
    end
    add_breadcrumbs('My disc', "/edisk_directories/"+@mini_root.id.to_s) #strona uzytkownika
    @abc = @rev_bread.split('/')
    @abc.each_index do |x|
      if !@abc[x].eql? ""
        @curr_id = EdiskDirectory.where(name: @abc[x], user_id: current_user.id)
        @curr_ids = @curr_id.ids.to_s
        @curr_ids[0] = ''
        @curr_ids = @curr_ids.chomp("]")
        @curr_path = "/edisk_directories/"+@curr_ids
        add_breadcrumbs(@abc[x], @curr_path)
      end
    end
  end

  def count_Size_for_user
    temp = 0
    EdiskFile.where(userID: current_user.id).each do |f|
      temp += f.efile.byte_size
    end
    current_user.update_attribute :current_size, temp
  end

  def expiration_time_into_string(expiration_time)
    @returning = ''
    case expiration_time
    when "5 minutes"
      @returning = "Limit: 5 minutes"
    when "20 minutes"
      @returning = "Limit: 20 minutes"
    when "60 minutes"
      @returning = "Limit: 60 minutes"
    when "24 hours"
      @returning = "Limit: 24 hours"
    when "nil"
      @returning = "No limit for expiration"
    end
  end

  def add_breadcrumbs(label, path = nil)
    @breadcrumbs << {
      label: label,
      path: path
    }
  end
  def set_breadcrumbs
    @breadcrumbs = []
  end
  # koneic wrzutki


  def return_all_files_from_directory(file_ed)
    @edisk_file = EdiskFile.where(edisk_directory_id: file_ed.id)
  end

  # def record_not_found(exception)
  #   redirect_to root_path, alert: "Nie istnieje taka strona"
  # end
  #
  def reload_file
    flash[:alert] = "User not found."
    respond_to do |format|
      format.js {render inline: "location.reload();" }
    end
  end
  private
  def edisk_directory_params
    params.require(:edisk_directory).permit( :name,:parent_id, :ancestry)
  end

  end
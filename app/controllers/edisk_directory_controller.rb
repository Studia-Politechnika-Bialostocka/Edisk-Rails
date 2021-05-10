class EdiskDirectoryController < ApplicationController
  before_action :authenticate_user!
  # rescue_from ::ActiveRecord::RecordNotFound, with: :record_not_found
  helper_method :return_all_files_from_directory, :is_there_base_directory2?
  after_action :count_Size_for_user

  def count_Size_for_user
    temp = 0
    EdiskFile.where(user_id: current_user.id).each do |f|
      temp += f.avatar.byte_size
    end
    current_user.update_attribute :current_size, temp
  end
  #wrzutka testowa
  before_action :set_breadcrumbs

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


  def return_all_files_from_directory(ed)
    @edisk_file = EdiskFile.where(edisk_directory_id: ed.id)
  end

  def is_there_base_directory2?
    if user_signed_in?
      if !EdiskDirectory.where(user_id: current_user.id).exists?(name: "home", ancestry: nil)
        current_user.edisk_directories.create(name:"home", ancestry: nil)
      end
    end
  end

  # def record_not_found(exception)
  #   redirect_to root_path, alert: "Nie istnieje taka strona"
  # end
  def new
    @edisk_directory = current_user.edisk_directories.children_of(params[:format]).new

    @test = EdiskDirectory.ancestors_of(@edisk_directory)
  end

  def create
    @edisk_directory = current_user.edisk_directories.children_of(params[:parent_id]).new(edisk_directory_params)
    actual_dir = EdiskDirectory.find(@edisk_directory.parent_id)
    if @edisk_directory.save
      redirect_to edisk_directory_path(actual_dir)
    else
      redirect_to new_edisk_directory_path(params[:parent_id])
    end
  end

  def edit
    @edisk_directory = EdiskDirectory.find(params[:id])
  end
  def update
      @edisk_directory = EdiskDirectory.find(params[:id])
      actual_dir = EdiskDirectory.find(@edisk_directory.parent_id)

      if @edisk_directory.update(edisk_directory_params)
        redirect_to edisk_directory_path(actual_dir)
      else
        redirect_to edit_edisk_directory_path(@edisk_directory)
  end
  end
  def destroy
    @edisk_directory = EdiskDirectory.find(params[:id])
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
    add_breadcrumbs('My disc', "/edisk_directory/"+@mini_root.id.to_s) #strona uzytkownika
    @abc = @rev_bread.split('/')
    @abc.each_index do |x|
      if !@abc[x].eql? ""
        @curr_id = EdiskDirectory.where(name: @abc[x], user_id: current_user.id)
        @curr_ids = @curr_id.ids.to_s
        @curr_ids[0] = ''
        @curr_ids = @curr_ids.chomp("]")
        @curr_path = "/edisk_directory/"+@curr_ids
        add_breadcrumbs(@abc[x], @curr_path)
      end
    end
  end

  private
  def edisk_directory_params
    params.permit(:name, :path, :parent_id, :ancestry, :user_id)
  end

  end
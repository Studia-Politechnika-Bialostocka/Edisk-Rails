class EdiskDirectoryController < ApplicationController
  before_action :authenticate_user!

  helper_method :return_all_files_from_directory

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
  # rescue_from ::ActiveRecord::RecordNotFound, with: :record_not_found

  # def record_not_found(exception)
  #   redirect_to root_path, alert: "Nie istnieje taka strona"
  # end
  def new
    @edisk_directory = current_user.edisk_directories.children_of(params[:format]).new
  end

  def create
    @edisk_directory = current_user.edisk_directories.children_of(params[:parent_id]).new(edisk_directory_params)
    temp1 = EdiskDirectory.find(@edisk_directory.parent_id)
    if @edisk_directory.save
      redirect_to edisk_directory_path(temp1),  notice: "Succesfully created"
    else
      redirect_to new_edisk_directory_path(params[:parent_id]), alert: "Name can't be blank"
    end
  end

  def edit

    @edisk_directory = EdiskDirectory.find(params[:id])
  end
  def update
      @edisk_directory = EdiskDirectory.find(params[:id])
      temp1 = EdiskDirectory.find(@edisk_directory.parent_id)

      if @edisk_directory.update(edisk_directory_params)
        redirect_to edisk_directory_path(temp1), notice: "Succesfully created"
      else
        redirect_to edit_edisk_directory_path(@edisk_directory), alert: "Name can't be blank"
  end
  end
  def destroy
    @edisk_directory = EdiskDirectory.find(params[:id])
    temp1 = @edisk_directory.parent_id
    @edisk_directory.destroy

    redirect_to edisk_directory_path(temp1), notice: "Sucesfully destroyed"
  end

  def show
    @edisk_directory = EdiskDirectory.find(params[:id])
    @edisk_directories = EdiskDirectory.children_of(@edisk_directory).where(user_id: current_user.id)

    #wrztuka
    add_breadcrumbs('Edisc Main Page', "/edisk_directory/0")
    add_breadcrumbs(@edisk_directory.name)
    @test = EdiskDirectory.ancestors_of(@edisk_directory)
    #if !test.name.nil?

    #end

    # !@edisk_directory.parent_id.nil? do
    #  add_breadcrumbs(@test.name)
    #  @test = EdiskDirectory.parent_of(@edisk_directory).where(user_id: current_user.id)
    #end
    # koniec
  end

  private
  def edisk_directory_params
    params.permit(:name, :path, :parent_id, :ancestry, :user_id)
  end

  end
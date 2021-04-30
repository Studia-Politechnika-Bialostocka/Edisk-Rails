class EdiskDirectoryController < ApplicationController
  before_action :authenticate_user!

  def new
    @edisk_directory = current_user.edisk_directories.children_of(params[:format]).new
  end

  def create
    @edisk_directory = current_user.edisk_directories.children_of(params[:parent_id]).new(edisk_directory_params)
    temp1 = EdiskDirectory.find(@edisk_directory.parent_id)
    if @edisk_directory.save
      redirect_to edisk_directory_path(temp1),  notice: "Succesfully created"
    else
      redirect_to root_path, notice:"Something goes wrong"
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
        render :edit, notice: "Something goes wrong"
  end
  end
  def destroy
    @edisk_directory = EdiskDirectory.find(params[:id])
    s = @edisk_directory.parent_id
    @edisk_directory.destroy

    redirect_to "/edisk_directories/" + s.to_s
  end

  def show
    @edisk_directory = EdiskDirectory.find(params[:id])
    @edisk_directories = EdiskDirectory.children_of(@edisk_directory).where(user_id: current_user.id)
    if @edisk_directories == nil
      "Nothing to show"
    end
  end

    private
    def edisk_directory_params
      params.permit(:name, :path, :parent_id, :ancestry, :user_id)
    end
  end
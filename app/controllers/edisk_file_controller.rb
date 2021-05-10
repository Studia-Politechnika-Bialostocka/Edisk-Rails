class EdiskFileController < ApplicationController

  def new
    @edisk_directory = EdiskDirectory.where(user_id: current_user.id).find(params[:format])
    @edisk_file = @edisk_directory.edisk_files.new
  end
  def create
    @edisk_directory = EdiskDirectory.where(user_id: current_user.id).find(params[:ed_id])
    @edisk_file = @edisk_directory.edisk_files.new(edisk_file_params)
    if @edisk_file.save
      redirect_to edisk_directory_path(@edisk_directory),  notice: "Succesfully created"
    else
      redirect_to new_edisk_file_path(params[:ed_id]), notice: "dafuq"
    end
  end
  def edit
    @edisk_file = EdiskFile.find(params[:id])
  end
  def update
    @edisk_file = EdiskFile.find(params[:id])
    actual_dir = @edisk_file.ed_id
    if @edisk_file.update(edisk_file_params)
      redirect_to edisk_directory_path(actual_dir), notice: "Successfully created"
    else
      redirect_to edit_edisk_file_path(@edisk_file)
    end
  end
  def destroy
    @edisk_file = EdiskFile.find(params[:id])
    actual_dir = @edisk_file.ed_id
    @edisk_file.avatar.purge
    @edisk_file.destroy
    redirect_to edisk_directory_path(actual_dir), notice: "Sucesfully destroyed"
  end
  # def show
  #
  # end
  # EdiskDirectory

  private
  def edisk_file_params
    params.permit(:name, :avatar, :ed_id, :userID)
  end

end
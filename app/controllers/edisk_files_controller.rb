class EdiskFilesController < ApplicationController

  def new
    @query = params[:format]
    @edisk_directory = EdiskDirectory.where(user_id: current_user.id).find(@query)
    @edisk_file = @edisk_directory.edisk_files.new
  end
  def create
    @query = params[:format]
    @edisk_directory = EdiskDirectory.where(user_id: current_user.id).find(params[:direct_id])
    @edisk_file = @edisk_directory.edisk_files.new(edisk_file_params)

    if @edisk_file.save
      redirect_to edisk_directory_path(@edisk_directory),  notice: "Succesfully created"
    else
      render :new, status: :unprocessable_entity
    end
  end
  def edit
    @edisk_file = EdiskFile.find(params[:id])
  end
  def update
    @edisk_file = EdiskFile.find(params[:id])
    actual_dir = @edisk_file.edisk_directory_id
    if @edisk_file.update(edisk_file_params)
      redirect_to edisk_directory_path(actual_dir), notice: "Successfully created"
    else
      render :edit, status: :unprocessable_entity
    end
  end
  def destroy
    @edisk_file = EdiskFile.find(params[:id])
    actual_dir = @edisk_file.edisk_directory_id
    @edisk_file.destroy
    redirect_to edisk_directory_path(actual_dir), notice: "Sucesfully destroyed"
  end

  private
  def edisk_file_params
    params.require(:edisk_file).permit(:name, :avatar, :userID)
  end

end
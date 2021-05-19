class EdiskFilesController < ApplicationController
  before_action :authenticate_user!
  after_action :integrity_on_filename, only: [:create, :update]

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
    @edisk_file = EdiskFile.where(userID: current_user.id).find(params[:id])
  end
  def update
    @edisk_file = EdiskFile.where(userID: current_user.id).find(params[:id])
    actual_dir = @edisk_file.edisk_directory_id
    if @edisk_file.update(edisk_file_params)
      redirect_to edisk_directory_path(actual_dir), notice: "Successfully created"
    else
      render :edit, status: :unprocessable_entity
    end
  end
  def destroy
    @edisk_file = EdiskFile.where(userID: current_user.id).find(params[:id])
    actual_dir = @edisk_file.edisk_directory_id
    # @edisk_file.avatar.purge_later
    @edisk_file.destroy
    redirect_to edisk_directory_path(actual_dir), notice: "Sucesfully destroyed"
  end

  private
  def edisk_file_params
    params.require(:edisk_file).permit(:name, :avatar, :userID)
  end

  def integrity_on_filename
    updateID = EdiskFile.where(userID: current_user.id).maximum(:updated_at)
    #unless (conditional) == if (!conditional)
    unless updateID.nil?
        temp = EdiskFile.find_by(userID: current_user.id, updated_at: updateID)
        temp.avatar.update(filename: temp.name)
    end
  end
end
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
    params[:edisk_file][:expiration_time] = params[:edisk_file][:number_of_expiration] + " " + params[:edisk_file][:type_of_expiration]
    @edisk_file = @edisk_directory.edisk_files.new(edisk_file_params)
    if @edisk_file.save
      redirect_to edisk_directory_path(@edisk_directory),  notice: "Succesfully created"
    else
      render :new, status: :unprocessable_entity
    end
  end
  def edit
    @edisk_file = EdiskFile.where(userID: current_user.id).find(params[:id])
    @time = ""
    @actual_dir = EdiskDirectory.find(@edisk_file.edisk_directory_id)
  end
  def update
    @edisk_file = EdiskFile.where(userID: current_user.id).find(params[:id])
    params[:edisk_file][:expiration_time] = params[:edisk_file][:number_of_expiration] + " " + params[:edisk_file][:type_of_expiration]
    actual_dir = @edisk_file.edisk_directory_id
    if @edisk_file.update(edisk_file_params)
      redirect_to edisk_directory_path(actual_dir), notice: "Successfully created"
    else
      render :edit, status: :unprocessable_entity
    end
  end
  # a little not for showing, but mostly for resetting the url
  def show
    @edisk_file = EdiskFile.where(userID: current_user.id).find(params[:id])
    ffilename = @edisk_file.efile.filename
    fcontent_type= @edisk_file.efile.content_type
    @edisk_file.efile.blob.open do |file|
      @edisk_file.efile.purge
      @edisk_file.efile.attach(io: file, filename: ffilename, content_type: fcontent_type)
    end
    flash[:notice] = "Link successfully expired"
    redirect_to edisk_directory_path(@edisk_file.edisk_directory_id)
  end

  def destroy
    @edisk_file = EdiskFile.where(userID: current_user.id).find(params[:id])
    actual_dir = @edisk_file.edisk_directory_id
    @edisk_file.destroy
    redirect_to edisk_directory_path(actual_dir), notice: "Sucesfully destroyed"
  end


  private
  def edisk_file_params
    params.require(:edisk_file).permit(:name, :efile, :userID, :edisk_directory_id, :expiration_time, :number_of_expiration, :type_of_expiration)
  end

  def integrity_on_filename
    updateID = EdiskFile.where(userID: current_user.id).maximum(:updated_at)
    #unless works like that (conditional) == if (!conditional)
    unless updateID.nil?
      file1 = EdiskFile.find_by(userID: current_user.id, updated_at: updateID)
      file_format = file1.efile.filename.to_s.split(".")
      if file_format.size.equal?(1)
        if temp === "text/plain"
          file1.efile.update(filename: file1.name += "." + "txt")
        else
          file1.efile.update(filename: file1.name += "." + file1.efile.content_type.split("/")[1])
        end
      else
        file1.efile.update(filename: file1.name += "." + file_format.last)
      end
    end
  end

end
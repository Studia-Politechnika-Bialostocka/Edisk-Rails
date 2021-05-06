class EdiskFileController < ApplicationController


  def new
    puts params
    puts "new------------------"
    @edisk_file = EdiskDirectory.find(params[:format]).edisk_files.new
  end
  def create
    puts params
    puts "create-------------------------------------"
    temp = EdiskDirectory.find(params[:ed_id])
    @edisk_file = temp.edisk_files.new(edisk_file_params)

    if @edisk_file.save
      redirect_to edisk_directory_path(temp),  notice: "Succesfully created"
    else
      redirect_to root_path, alert: "Name can't be blank"
    end
  end
  # def show
  #   @edisk_files = EdiskFile.where(edisk_directories_id:)
  # end
  # EdiskDirectory

  private
  def edisk_file_params
    params.permit(:name, :efile)
  end

end
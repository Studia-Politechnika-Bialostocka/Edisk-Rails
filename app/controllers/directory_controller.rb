class DirectoryController < ApplicationController
  before_action :user_signed_in?

    def new
      @edisk_directory = current_user.edisk_directories.build
    end

    def create
      @edisk_directory = current_user.edisk_directories.new(edisk_directory_params)
      @edisk_directory.path = request.fullpath
      ancestor = request.original_fullpath
      EdiskDirectory.find_by(name:ancestor[ 1..ancestor.length - 1 ] ).children.create(name: @edisk_directory.name)

      if @edisk_directory.save
        puts "Succesfully created "
      else
        redirect_to original_url, notice:"Something goes wrong"
      end
    end
    def index
      @edisk_directories = EdiskDirectory.all
    end

  def destroy
    @edisk_directory = EdiskDirectory.find(name:params[:id])
    if @edisk_directory != nil
      @edisk_directory.destroy
    end

  end

  def show
    @edisk_directory = params[:path]
    if @edisk_directory.nil?
      redirect_to root_path
    end
    @edisk_directory = EdiskDirectory.where(@hih)
  end

    private
    def edisk_directory_params
      params.require(:edisk_directory).permit(:name, :user_id)
    end
  end
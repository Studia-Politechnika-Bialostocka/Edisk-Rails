class EdiskDirectoryController < ApplicationController
  before_action :authenticate_user!

    def new
      @edisk_directory = EdiskDirectory.new
    end

    def create
      # puts(verified_user)
      # @edisk_directory = current_user.EdiskDirectory.new(edisk_directory_params)
      # @edisk_directory = nil
      # if verified_user && cookies.signed['user.expires_at'] > Time.now
      @edisk_directory = current_user.edisk_directories.new(edisk_directory_params)
      @edisk_directory.pathNName = @edisk_directory.path+">"+@edisk_directory.name
      # else
      #   redirect_to root_path, notice: "Succesfully created"
      # end
      # puts(@edisk_directory)
      if @edisk_directory.save
        redirect_to root_path, notice: "Succesfully created"
      else
        redirect_to root_path, notice:"Something goes wrong"
      end
    end

    def index
      @edisk_directory = EdiskDirectory.all
      if @edisk_directory == nil
        return nil
      end
    end

  def destroy
    @edisk_directory = EdiskDirectory.find(name:params[:id])
    if @edisk_directory != nil
      @edisk_directory.destroy
    end

  end

  def show
    @edisk_directories = EdiskDirectory.where(path: params[:path], user_id: current_user.id)
    if(@edisk_directories == nil)
      "Nothing to show"
    end
  end

    private
    def edisk_directory_params
      params.permit(:name, :path, :pathNName)
    end
  end
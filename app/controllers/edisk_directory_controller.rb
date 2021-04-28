class EdiskDirectoryController < ApplicationController
  before_action :authenticate_user!

  def new
    @edisk_directory = EdiskDirectory.new
  end

  def create

    @edisk_directory = current_user.edisk_directories.children_of(params[:id]).new(edisk_directory_params)

    if @edisk_directory.save
      redirect_to "/edisk_directories/" + @edisk_directory.parent_id.to_s, notice: "Succesfully created"
    else
      render new, notice:"Something goes wrong"
    end
  end

  def edit
    @edisk_directory = EdiskDirectory.find(params[:id])
  end
  def update
      @edisk_directory = EdiskDirectory.find(params[:id])

      if @edisk_directory.update(edisk_directory_params)
        redirect_to root_path
      else
        render :edit, notice: "Something goes wrong"
  end
  end
  # def index
  #   @edisk_directory = EdiskDirectory.all
  # end

  def destroy
    @edisk_directory = EdiskDirectory.find(params[:id])
    s = @edisk_directory.parent_id
    @edisk_directory.destroy

    redirect_to "/edisk_directories/" + s.to_s
  end

  def show
    @edisk_directory = EdiskDirectory.find(params[:id])
    @edisk_directories = nil
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
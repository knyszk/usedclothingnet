class PhotosController < ApplicationController
  before_action :require_user_logged_in
  
  def new
    @photo = current_user.photos.new
  end

  def create
    @photo = current_user.photos.new(photo_params)

    if @photo.save
      redirect_to :root
    else
      render :new
    end
  end

  private

  def photo_params
    params.require(:photo).permit(:caption, :image)
  end
  
  # def correct_user
  #   @micropost = current_user.microposts.find_by(id: params[:id])
  #   unless @micropost
  #     redirect_to root_url
  #   end
  # end
end
class PhotosController < ApplicationController
  before_action :require_user_logged_in
  
  def new
    @photo = current_user.photos.new
  end

  def create
    @photo = current_user.photos.new(photo_params)
    if @photo.image.attached?
      if @photo.save
        flash[:success] = '投稿しました。'
        redirect_to :root
      end
    else
      @photos = current_user.feed_photos.order(id: :desc)
      flash.now[:danger] = '投稿に失敗しました。'
      render :new
    end
  end
  
  def show
    @photo = Photo.find(params[:id])
    @comments = @photo.comments
    @comment = @photo.comments.build
  end
  
  def destroy
    @photo = Photo.find(params[:id])
    if @photo.present?
      @photo.destroy
      flash[:success] = '削除しました。'
    end
    redirect_to root_url
  end

  private

  def photo_params
    params.require(:photo).permit(:caption, :image)
  end
  
  def correct_user
    @photo = current_user.photos.find_by(id: params[:id])
    unless @photo
      redirect_to root_url
    end
  end
end
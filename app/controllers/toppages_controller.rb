class ToppagesController < ApplicationController
  def index
    if logged_in?
      @photo = current_user.photos.build
      @photos = current_user.feed_photos.order(id: :desc)
    end
  end
end

class CommentsController < ApplicationController
  before_action :require_user_logged_in

  def create
    photo = Photo.find(params[:photo_id])
    @comment = photo.comments.build(comment_params)
    @comment.user_id = current_user.id
    if @comment.save
      flash[:success] = "コメントしました"
      redirect_back(fallback_location: root_path)
    else
      flash[:danger] = "コメントできませんでした"
      redirect_back(fallback_location: root_path)
    end
  end
  
  
  def destroy
    @comment = Comment.find(params[:id])
    if @comment.destroy
      flash[:success] = 'コメントを削除しました。'
      redirect_back(fallback_location: root_path)
    else
      flash.now[:danger] = 'コメント削除に失敗しました'
      redirect_to photo_path
    end
  end

  private

    def comment_params
      params.require(:comment).permit(:content)
    end
end

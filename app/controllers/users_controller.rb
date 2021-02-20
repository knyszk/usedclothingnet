class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:index, :show, :followings, :followers]

  def index
    @users = User.order(id: :desc)
  end

  def show
    @user = User.find(params[:id])
    @photos = @user.photos.order(id: :desc)
    counts(@user)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
      if @user.save
        flash[:success] = 'ユーザを登録しました。'
        redirect_to @user
      else
        flash.now[:danger] = 'ユーザの登録に失敗しました。'
        render :new
      end
  end
  
  def followings
    @user = User.find(params[:id])
    @followings = @user.followings
    counts(@user)
  end
  
  def followers
    @user = User.find(params[:id])
    @followers = @user.followers
    counts(@user)
  end
  
  def edit
    @user = User.find_by(id: params[:id])
  end
  
  def update
    @user = User.find_by(id: params[:id])
    @user.update(user_params)
      redirect_to user_path(@user)
  end
  
  def search
    if params[:name].present?
      @users = User.where('name LIKE ?', "%#{params[:name]}%")
    else
      @users = User.none
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :introduction, :image)
  end
  
  def correct_user
    @user = current_user.find_by(id: params[:id])
    unless @user
      redirect_to root_url
    end
  end
end

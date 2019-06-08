class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:show, :index]
  def index
    @users = User.order(id: :desc).page(params[:page]).per(25)
  end

  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.order(id: :desc).page(params[:page])
    counts(@user)
  end

  def create
    @user = User.new(params_user)
    if @user.save
      flash[:success] = "ユーザを登録しました。"
      redirect_to @user
    else
      flash.now[:danger] = "ユーザの登録に失敗しました"
      render :new
    end
  end

  def new
    @user = User.new
  end
  
  private
  
  def params_user
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
  
end

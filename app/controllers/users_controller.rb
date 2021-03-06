class UsersController < ApplicationController
  
  before_action :require_user_logged_in, only: [:show]
  
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

  def show
    #お気に入りにしたレビューを表示する処理
    @user = User.find(params[:id])
    @likes = @user.likes
    @review = Review.new
  end
  
  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end

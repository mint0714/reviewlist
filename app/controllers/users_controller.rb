class UsersController < ApplicationController
  def new
    @user = User.new
    
    if @user.save
      flash[:success] = 'ユーザを登録しました。'
      redirect_to @user
    else
      flash.now[:danger] = 'ユーザの登録に失敗しました。'
      render :new
    end
  end

  def create
  end

  def show
    @user = User.find(params[:id])
    #お気に入りにしたレビューを表示する処理
  end
  
  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end

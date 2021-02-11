class UsersController < ApplicationController
  
  
  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    
    if @user.save
      flash[:notice] = "ユーザを登録しました"
      redirect_to @user
    else
      flash[:notice] = "登録に失敗しました"
      render :new
    end
  end

  def edit
    set_user
  end
  
  def update
    set_user
    
    if @user.update(user_params)
      flash[:success] = "正常に更新されました"
      redirect_to @user
    else
      flash.now[:danger] = "更新に失敗しました"
      render :edit
    end
  end
  
  private
  
  def set_user
    @user = User.find_by(params[:id])
  end
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :introduction)
  end
  
end

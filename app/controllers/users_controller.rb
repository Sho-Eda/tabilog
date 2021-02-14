class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:show, :edit]
  
  
  def show
    # set_user
    set_user

    @posts = @user.posts.order(id: :desc).page(params[:page])
    counts(@user)

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
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to  current_user
    end
  end
  
  
  def update
    @user = User.find(params[:id])
    
    #編集しようとしてるユーザーがログインユーザーとイコールかをチェック
    if current_user == @user
       if @user.update(user_params)
        flash[:success] = "正常に更新されました"
        redirect_to current_user
      else
        flash.now[:danger] = "更新に失敗しました"
        render :edit
      end
    else
      redirect_to current_user
    end  
  end
  
  private
  
  def set_user
    @user = User.find(params[:id])
  end
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :introduction)
  end
  
  
  
end

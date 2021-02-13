class PostsController < ApplicationController
  before_action :require_user_logged_in, only: [:show, :edit]
  before_action :corrent_user, only: [:destroy]
  
  def new
     @post = current_user.posts.build  # form_with 用
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:success] = '投稿しました。'
      redirect_to current_user
    end
  end

  def destroy
    @post.destroy
    flash[:success] = 'メッセージを削除しました。'
    redirect_back current_user
    
  end
  
  def edit
    @post = current_user.posts.find_by(id: params[:id])
  end
  
  def update
    @post = current_user.posts.find_by(id: params[:id])
    
    if @post.update(post_params)
      flash[:success] = 'Message は正常に更新されました'
      redirect_to corrent_user
      
    else
      flash.now[:danger] = 'Message は更新されませんでした'
      render :edit
    end
  end
  
  private
  
  def post_params
    params.require(:post).permit(:content, :image)
    # if image = params[:content][:image]
    # @post.image.attach(image)
    # end
  end
  
  def corrent_user
    @post = current_user.posts.find_by(id: params[:id])
    unless @post
      redirect_to current_user
    end
  end
  
end

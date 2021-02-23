class PostsController < ApplicationController
  before_action :require_user_logged_in
  before_action :corrent_user, only: [:destroy]
  
  def show
    @post = Post.find(params[:id])
    @comments = @post.comments.page(params[:page]).per(3)
    @comment = Comment.new
    
  end
  
  def new
     @post = current_user.posts.build  
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
    flash[:success] = '削除しました。'
    redirect_to current_user
    
  end
  
  def edit
    @post = Post.find_by(id: params[:id])
  end
  
  def update
    @post = Post.find_by(id: params[:id])
    
    if @post.update(post_params)
      flash[:success] = '更新しました'
      redirect_to current_user
      
    else
      flash.now[:danger] = '更新されませんでした'
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

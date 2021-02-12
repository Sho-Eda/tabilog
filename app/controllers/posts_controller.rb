class PostsController < ApplicationController
  before_action :require_user_logged_in, only: [:show, :edit]
  
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
  end
  
  def post_params
    params.require(:post).permit(:content)
  end
  
end

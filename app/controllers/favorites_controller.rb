class FavoritesController < ApplicationController
  before_action :require_user_logged_in
  
  def create
    post = Post.find(params[:post_id])
    current_user.like(post)
    flash[:success] = 'お気に入りを登録しました。'
    redirect_to current_user
  end

  def destroy
    post = Post.find(params[:post_id])
    current_user.unlike(post)
    flash[:danger] = 'お気に入りを解除しました。'
    redirect_to current_user
  end  
end

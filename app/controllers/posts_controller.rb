class PostsController < ApplicationController
  before_action :require_user_logged_in
  before_action :corrent_user, only: [:destroy]
  
  def index
    @tag_list = Tag.all              #ビューでタグ一覧を表示するために全取得。
    @posts = Post.all                #ビューで投稿一覧を表示するために全取得。
    @post = current_user.posts.new   #ビューのform_withのmodelに使う。
  end
  
  def show
    @post = Post.find(params[:id])
    @comments = @post.comments.page(params[:page]).per(3)
    @comment = Comment.new
    @post_tags = @post.tags     
    
  end
  
  def new
     @post = current_user.posts.build  
  end

  def create
    @post = current_user.posts.build(post_params)
    tag_list = params[:post][:tag_name].split(',')
    
    if @post.save
      @post.save_tag(tag_list)    
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
      redirect_to root_url
      
    else
      flash.now[:danger] = '更新されませんでした'
      render :edit
    end
  end
  
  def search
    @tag_list = Tag.all  #こっちの投稿一覧表示ページでも全てのタグを表示するために、タグを全取得
    @tag = Tag.find(params[:tag_id])  #クリックしたタグを取得
    @posts = @tag.posts.all           #クリックしたタグに紐付けられた投稿を全て表示
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
      redirect_to root_url
    end
  end
  
end

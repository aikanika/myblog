class BlogsController < ApplicationController
  skip_before_action :require_sign_in!

  # blog一覧表示
  def index
    logger.debug "テスト"
    #作成日の降順で表示
    @posts = Post.all.order(created_at: 'desc')
  end

  # 詳細画面表示
  def show
    @post = Post.find(params[:id])
  end

  # 新規作成画面表示
  def new
    @post = Post.new
  end

  # 記事追加
  def create
    # render plain: params[:post].inspect
    # save
    @post = Post.new(post_params)
    if @post.save
      # redirect
      redirect_to posts_path
    else
      # render plain: @post.errors.inspect
      render 'new'
    end
  end

  # 編集画面表示
  def edit
    @post = Post.find(params[:id])
  end

  # 更新処理
  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to posts_path #一覧に戻る
    else
      render 'edit'
    end
  end

  # 削除処理
  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_path #一覧に戻る
  end



  private
    def post_params
      # strong parameter : パラメータを強めにチェックする
      params.require(:post).permit(:title,:body)
    end
end
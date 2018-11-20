class BlogsController < ApplicationController
  skip_before_action :require_sign_in!

  # blog一覧表示
  def index
    @user = User.all.first
    @categories = Category.all.order(id: :asc)

    #作成日の降順で表示
    @posts = Post.where(published: "1").order(created_at: :desc).page(params[:page]).per(PER)
    if params[:category_id].present?
      @posts = Post.get_by_category_id(params[:category_id],"1").page(params[:page]).per(PER)
    end
  end

  # 詳細画面表示
  def show
    @categories = Category.all.order(id: :asc)
    @post = Post.find(params[:id])
  end


end

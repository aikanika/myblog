class BlogsController < ApplicationController
  skip_before_action :require_sign_in!

  # blog一覧表示
  def index
    @categories = Category.all.order(id: :asc)

    #作成日の降順で表示
    @posts = Post.all.order(created_at: 'desc')
    #@posts = Post.all.order(created_at: :desc)
    @posts = Post.all.order(created_at: :desc).page(params[:page]).per(PER)
    if params[:category_id].present?
      @posts = Post.get_by_category_id(params[:category_id]).page(params[:page]).per(PER)
    end
  end



end

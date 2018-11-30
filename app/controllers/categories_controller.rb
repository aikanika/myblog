class CategoriesController < ApplicationController

  # カテゴリ一覧表示
  def index
    #作成日の降順で表示
    @categories_list = Category.all.order(created_at: :desc).page(params[:page]).per(PER)
  end

  # 新規作成画面表示
  def new
    @category = Category.new
  end

  # カテゴリ追加
  def create
    @category = Category.new(category_params)
    if @category.save
      # redirect
      redirect_to categories_path
    else
      # render plain: @post.errors.inspect
      render 'new'
    end
  end

  # 編集画面表示
  def edit
    @category = Category.find(params[:id])
  end

  # 更新処理
  def update
    @category = Category.find(params[:id])

    if @category.update(category_params)
      redirect_to categories_path #一覧に戻る
    else
      render 'edit'
    end
  end

  # 削除処理
  def destroy
    @category = Category.find(params[:id])
    @category.destroy
    redirect_to categories_path #一覧に戻る
  end

  private
    def category_params
      # strong parameter : パラメータを強めにチェックする
      params.require(:category).permit(:name,:image)
    end
end

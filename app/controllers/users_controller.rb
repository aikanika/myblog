class UsersController < ApplicationController
  skip_before_action :require_sign_in!

  def new

    @user = User.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @current_user == @user
      if @user.update(user_params)
        flash[:success] = 'ユーザー情報を編集しました。'
      else
        flash.now[:danger] = 'ユーザー情報の編集に失敗しました。'
      end

      redirect_to posts_path
    else
        redirect_to posts_path
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to login_path
    else
      render 'new'
    end
  end

  private

    def user_params
      params.require(:user).permit(:name, :mail, :password, :password_confirmation, :image , :introduction)
    end

end

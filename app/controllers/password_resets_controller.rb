class PasswordResetsController < ApplicationController
  skip_before_action :require_sign_in!
  before_action :get_user,   only: [:edit, :update]
  before_action :valid_user, only: [:edit, :update]
  before_action :check_expiration, only: [:edit, :update]

  def new
  end

  def edit
  end

  def update
    if params[:user][:password].empty?                  # 空白文字
      flash.now[:danger] = "パスワードに空文字を指定することはできません。"
      render 'edit'
    elsif @user.update_attributes(user_params)          # パスワード更新
      log_in @user
      flash.now[:success] = "パスワードが再設定されました。"
      redirect_to posts_path
    else
      flash.now[:danger] = "パスワードが不正です。"
      render 'edit' 
    end
  end

  def create
   @user = User.find_by(mail: params[:password_reset][:mail])
   if @user
     @user.create_reset_digest
     @user.send_password_reset_mail
     flash.now[:info] = "パスワードリセットメールが送信されました。"
     redirect_to login_path
   else
     flash.now[:danger] = "メールアドレスが誤っています。"
     render 'new'
   end
  end

 private

 def user_params
   params.require(:user).permit(:password, :password_confirmation)
 end

 # beforeフィルタ
 def get_user
   @user = User.find_by(mail: params[:mail])
 end

 # 有効なユーザーかどうか確認する
 def valid_user
   unless (@user && @user.activated? &&
           @user.authenticated?(:reset, params[:id]))
     redirect_to root_url
   end
 end

 # トークンが期限切れかどうか確認する
 def check_expiration
   if @user.password_reset_expired?
     flash[:danger] = "パスワード再設定の有効期限が切れています。"
     redirect_to new_password_reset_url
   end
 end

end

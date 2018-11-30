class PasswordResetsController < ApplicationController
  skip_before_action :require_sign_in!

  def new
  end

  def edit
  end

  def create
   @user = User.find_by(mail: params[:password_reset][:mail])
   if @user
     @user.create_reset_digest
     @user.send_password_reset_email
     flash.now[:info] = "パスワードリセットメールが送信されました。"
     redirect_to login_path
   else
     flash.now[:danger] = "メールアドレスが誤っています。"
     render 'new'
   end
 end

end

class SessionsController < ApplicationController
  before_action :require_sign_in!, only: [:destroy]
  before_action :set_user, only: [:create]

  def new

  end

  def create
    #暗号化されてないパスワードとpassword_digest属性値の一致を検証
    if @user.authenticate(session_params[:password])
      if @user.activated?
        log_in @user
        params[:session][:remember_me] == '1' ? remember(@user) : forget(@user)
        redirect_to posts_path
      else
        flash.now[:warning] = t('.flash.not_active_account')
        render 'new'
      end

    else
      flash.now[:danger] = t('.flash.invalid_password')
      render 'new'
    end
  end

  def destroy
    log_out
    redirect_to login_path
  end

  def sign_in(user)
    remember_token = User.new_token
    cookies.permanent[:user_remember_token] = remember_token
    user.update!(remember_token: User.digest(remember_token))
    @current_user = user
  end

  private

    def set_user
      if User.exists?
        @user = User.find_by!(mail: session_params[:mail])
      else
        redirect_to signup_path
      end
    rescue
      flash.now[:danger] = t('.flash.invalid_password')
      render action: 'new'
    end

    # 許可するパラメータ
    def session_params
      params.require(:session).permit(:mail, :password)
    end

end

class ApplicationController < ActionController::Base
  include SessionsHelper
  before_action :current_user
  before_action :require_sign_in!

  PER = 7

  #CSRF対策
  protect_from_forgery with: :exception

  def current_user
    # cookieからトークンを取得後ハッシュ化
    remember_token = User.digest(cookies[:user_remember_token])
    # cookieと同じトークンを持ったユーザを取得
    @current_user ||= User.find_by(remember_token: remember_token)
  end

  def sign_in(user)
    remember_token = User.new_token
    cookies.permanent[:user_remember_token] = remember_token
    User.update(remember_token: User.digest(remember_token))
    @current_user = user
  end

  def sign_out
    @current_user = nil
    cookies.delete(:user_remember_token)
  end


private
  # ユーザ登録していなかったらユーザ登録画面へ遷移する
  # ログインしていなかったらログイン画面へ遷移させる
  def require_sign_in!
    if User.exists?
      redirect_to login_path unless logged_in?
    else
      redirect_to signup_path
    end
  end
end

class ApplicationController < ActionController::Base
  before_action :current_user
  before_action :require_sign_in!
  helper_method :signed_in?
  PER = 7

  #CSRF対策
  protect_from_forgery with: :exception

  def current_user
    # cookieからトークンを取得後暗号化
    remember_token = User.encrypt(cookies[:user_remember_token])
    # cookieと同じトークンを持ったユーザを取得
    @current_user ||= User.find_by(remember_token: remember_token)
  end

  def sign_in(user)
    remember_token = User.new_remember_token
    cookies.permanent[:user_remember_token] = remember_token
    user.update!(remember_token: User.encrypt(remember_token))
    @current_user = user
    redirect_to posts_path
  end

  def sign_out
    @current_user = nil
    cookies.delete(:user_remember_token)
  end

  def signed_in?
    @current_user.present?
  end

private
  # ログインしていなかったらログイン画面へ遷移させる
  def require_sign_in!
    redirect_to login_path unless signed_in?
  end
end

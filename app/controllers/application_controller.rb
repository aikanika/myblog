class ApplicationController < ActionController::Base
  include SessionsHelper
  before_action :current_user
  before_action :require_sign_in!

  PER = 7

  #CSRF対策
  protect_from_forgery with: :exception

  # 現在ログイン中のユーザーを返す (いる場合)
  def current_user
    if (user_id = session[:user_id])
      @current_user ||= User.find_by(id: user_id)
    elsif (user_id = cookies.signed[:user_id])
      user = User.find_by(id: user_id)
      if user && user.authenticated?(:remember, cookies[:remember_token])
        log_in user
        @current_user = user
      end
    end
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

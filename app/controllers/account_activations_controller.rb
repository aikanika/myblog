class AccountActivationsController < ApplicationController
  skip_before_action :require_sign_in!
  def edit
    user = User.find_by(mail: params[:mail])
    if user && !user.activated? && user.authenticated?(:activation, params[:id])
      user.update_attribute(:activated,    true)
      user.update_attribute(:activated_at, Time.zone.now)
      flash[:success] = "アカウントが有効になりました。"
      redirect_to login_path
    else
      flash[:danger] = "アカウント有効化のリンクが無効です。"
      redirect_to login_path
    end
  end
end

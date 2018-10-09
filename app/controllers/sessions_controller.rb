class SessionsController < ApplicationController
  before_action :require_sign_in!, only: [:destroy]
  before_action :set_user, only: [:create]

  def new
#    logger.debug "テスト"

  end

  def create
    if @user.authenticate(session_params[:password])
      sign_in(@user)
#      redirect_to controller: 'posts', action: 'list'
#logger.debug @user.inspect

      #redirect_to posts_path
    else
      flash.now[:danger] = t('.flash.invalid_password')
      render 'new'
    end
  end

  def destroy
    sign_out
    redirect_to login_path
  end

  private

    def set_user
      @user = User.find_by!(mail: session_params[:mail])
    rescue
      flash.now[:danger] = t('.flash.invalid_mail')
      render action: 'new'
    end

    # 許可するパラメータ
    def session_params
      params.require(:session).permit(:mail, :password)
    end

end

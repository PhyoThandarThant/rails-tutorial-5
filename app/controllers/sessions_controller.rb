class SessionsController < ApplicationController
  def new
  end

  def create
    @user =User.find_by(email: params[:session][:email].downcase)
    if @user && @user.authenticate(params[:session][:password])
      # ログイン→ユーザー情報ページにダイレクト
      log_in @user
      params[:session][:remember_me] == '1'? remember(@user) : forget(@user)
      redirect_to @user
    else
      #ログイン失敗→エーラメッセージを表示
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end

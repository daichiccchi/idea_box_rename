class SessionsController < ApplicationController
  def new
  end
  
  def create
      @user = User.find_by(email: params[:session][:email].downcase)
    if @user && @user.authenticate(params[:session][:password]) #=if user && user.authenticate(params[:session][:password])
      # ユーザーログイン後にユーザー情報のページにリダイレクトする
      if @user.activated?
        log_in @user
        params[:session][:remember_me] == '1' ? remember(@user) : forget(@user)
      # remember user ←これを有効にするとチェックボックスのテストでエラーになる
        redirect_back_or @user
        flash[:success] = 'ログインに成功しました'
      else
        message  = "こちらのアカウントは認証されていません"
        message += "送信されたメールをご確認ください"
        flash[:danger] = message
        redirect_to root_url
      end
    else
    flash.now[:danger] = 'メールアドレスまたはパスワードが違います' #aエラーメッセージを作成
    render 'new'
    end
  end
  
  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end

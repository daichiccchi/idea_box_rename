class PasswordResetsController < ApplicationController
  before_action :get_user,         only: [:edit, :update]
  before_action :valid_user,       only: [:edit, :update]
  before_action :check_expiration, only: [:edit, :update]
  def new
  end
  
  def create
    @user = User.find_by(email: params[:password_reset][:email].downcase)
    if @user
      @user.create_reset_digest
      @user.send_password_reset_email
      flash[:info] = "送信されたメールからパスワードを再発行してください"
      redirect_to root_url
    else
      flash.now[:danger] = "メールアドレスが正しくありません"
      render 'new'
    end
  end

  def edit
  end
  
  def update
    if params[:user][:password].empty?
      @user.errors.add(:password, :blank)
      render 'edit'
    elsif @user.update_attribute(:reset_digest, nil)
      log_in @user
      flash[:success] = "新しくパスワードを設定しました"
      redirect_to @user
    else
      render 'edit'
    end
  end
  
  private
  
  def user_params
    params.require(:user).permit(:password, :password_confirmation)
  end
  
  #beforeフィルター
  def get_user
    @user = User.find_by(email: params[:email])
  end
  #有効なユーザーか確認
  def valid_user
    unless (@user && @user.activated? &&
            @user.authenticated?(:reset, params[:id]))
    redirect_to root_url
    end
  end
  #トークンが期限切れかどうか確認する
  def check_expiration
    if @user.password_reset_expired?
      flash[:danger] = "有効期限が切れています"
      redirect_to new_password_reset_url
    end
  end
end

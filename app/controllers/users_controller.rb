class UsersController < ApplicationController
before_action :logged_in_user, only: [:index, :edit, :update, :destroy] #editアクションとupdateアクションの時のみlogged_in_userメソッドを与える
before_action :correct_user,   only: [:edit, :update] #上に同じく、　　　　　　　　　　　　　　corre_userメソッドを与える
before_action :admin_user,     only: :destroy
  def show
    @user = User.find(params[:id])
    redirect_to root_url and return unless @user.activated?
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      @user.send_activation_email # アカウント有効化メールの送信
      flash[:info] = "送信されたメールからアカウントを認証してください" # アカウント有効化メッセージの表示
      redirect_to root_url # ホーム画面へリダイレクトする
    else
      render 'new'
    end
  end
  
  def index
    @users = User.all.page(params[:page]).per(20)
  end
  
  def show
    @user = User.find(params[:id])
    @topics = @user.topics
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = "プロフィールを変更しました"
      redirect_to @user
    else
      render 'edit'
    end
  end
  
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "ユーザーを削除しました"
    redirect_to users_url
  end
  private
  
    def user_params
      params.require(:user).permit(:name, :email, :user_area, :user_job,
                                   :school_year, :avatar,
                                   :password,
                                   :password_confirmation)
    end
    
    # ログイン済みユーザーかどうかを確認
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "ログインしてください"
        redirect_to login_url
      end
    end
    
    #正しいユーザーかどうかを確認
    def correct_user
      @user = User.find(params[:id])
      redirect_to (root_url) unless current_user?(@user)
    end
    
    # 管理者かどうか確認
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
end

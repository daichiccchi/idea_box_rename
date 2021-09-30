class TopicsController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :create, :destroy] #editアクションとupdateアクションの時のみlogged_in_userメソッドを与える
  before_action :correct_user,   only: [:edit, :update] #上に同じく、　　　　　　　　　　　　　　corre_userメソッドを与える
  
  def index
    @topics = Topic.all
  end
  
  def new
    @topic = Topic.new
  end
  
  def create
    @topic = current_user.topics.new(topic_params)
    if @topic.save
      redirect_to topics_path 
      flash[:success] = '投稿が完了しました'
    else
      flash[:danger]  = '投稿に失敗しました'
      render :new
    end
  end
  
  private
  
  def topic_params
    params.require(:topic).permit(:image, :description)
  end
  
   #ログイン済みユーザーかどうかを確認
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end
    
    #正しいユーザーかどうかを確認
    def correct_user
      @user = User.find(params[:id])
      redirect_to (root_url) unless current_user?(@user)
    end
    
end
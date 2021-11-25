class TopicsController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :create, :destroy] #editアクションとupdateアクションの時のみlogged_in_userメソッドを与える
  before_action :correct_user,   only: [:edit, :update] #上に同じく、　　　　　　　　　　　　　　corre_userメソッドを与える
  
  def index
    @topics = Topic.all.order(created_at: :desc) 
    @topics = @topics.joins(:labels).where(labels: { id: params[:label_id] }) if params[:label_id].present?
    @user_show = false #パーシャルの条件分岐で使用
  end
  
  def new
    @topic = Topic.new
  end
  
  def show
    @comment = Comment.new
    @topic = Topic.find(params[:id])
    @comments = @topic.comments
    @user = @topic.user
  end
  
  def create
    @topic = current_user.topics.new(topic_params)
    if @topic.save
      labelling = Labelling.new       #新しくラベルを生成
      labelling.topic_id = @topic.id  #topicと紐づけ
      labelling.label_id = params[:topic][:label_ids] #topicと紐づけられたラベルを保存        
      labelling.save 
      
      yearing = Yearing.new       #新しく学年を生成
      yearing.topic_id = @topic.id  #topicと紐づけ
      yearing.year_id = params[:topic][:year_ids] #topicと紐づけられたラベルを保存        
      yearing.save  
      redirect_to topics_path 
      flash[:success] = '投稿が完了しました'
    else
      render :new
    end
  end
  
  def destroy
    topic = Topic.find(params[:topic_id])
    if topic.user_id == current_user.id
      topic.destroy
      redirect_to current_user
      flash[:success] = '投稿を削除しました'
    end
  end
  
  private
  
  def topic_params
    params.require(:topic).permit( :docment, :description, {images: []}, { label_ids:[]}, { year_ids:[]})                                                                                                
   

  end
  
  def user_params
      params.require(:user).permit(:name, :email, :user_area, :user_job,
                                   :school_year, :avatar,
                                   :password,
                                   :password_confirmation)
  end
  
   #ログイン済みユーザーかどうかを確認
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
      redirect_to (root_url) unless correct_user?(@user)
    end
    
end
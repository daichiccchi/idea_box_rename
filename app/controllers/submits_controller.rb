class SubmitsController < ApplicationController
  before_action :logged_in_user
  
  def index
    @submit_topics = current_user.submit_topics
  end

  def create
    Submit.create(user_id: current_user.id, topic_id: params[:topic_id])
    @topic = Topic.find(params[:topic_id])
    # submit = Submit.new
    # submit.user_id = current_user.id
    # submit.topic_id = params[:topic_id]

    # if submit.save
    #   redirect_to topics_path
    #   flash[:success] = 'マイフォルダに保存しました'
    # else
    #   redirect_to 
    #   flash[:danger]  = '保存に失敗しました'
    # end
  end
  
 def destroy
   if params[:button] == "garbage"
       #submit_indexのごみ箱のボタンを実行したとき
       Submit.find_by(user_id: current_user.id, topic_id: params[:topic_id]).destroy
       @topic = Topic.find(params[:topic_id])
       flash[:success] = "マイフォルダから削除しました"
       redirect_to submits_index_path
   else
       Submit.find_by(user_id: current_user.id, topic_id: params[:topic_id]).destroy
       @topic = Topic.find(params[:topic_id])
       #lash[:success] = "マイフォルダから削除しました"
       #redirect_to submits_index_path
   end
 end
 
  private
   #ログイン済みユーザーかどうかを確認
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "ログインしてください"
        redirect_to login_url
      end
    end
    
  
    def user_params
      params.require(:user).permit(:name, :email, :user_area, :user_job,
                                   :school_year, :avatar,
                                   :password,
                                   :password_confirmation)
    end

end


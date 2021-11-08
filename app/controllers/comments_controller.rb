class CommentsController < ApplicationController
  before_action :logged_in_user
  
  def create
    @comment = Comment.new
    @comment.user_id = current_user.id
    @comment.topic_id = params[:topic_id]
    @comment.content = params[:content]
    @topic = Topic.find(params[:topic_id])
    @user = User.find(params[:user_id])
    @comment.save
    @comments = @topic.comments
  end
  
  def destroy
    @comment = Comment.find(params[:id])
    @topic = @comment.topic
    @comment.destroy
    @comments = @topic.comments
    flash[:success] = 'コメントを削除しました'
  end
  
  private
  
  # def comment_params
  #   params.require(:comment).permit(:content)
  # end
  
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

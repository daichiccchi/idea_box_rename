class CommentsController < ApplicationController
  before_action :logged_in_user
  
  def create
    @comment = Comment.new
    @comment.user_id = current_user.id
    @comment.topic_id = params[:topic_id]
    @comment.content = params[:content]
    if @comment.save
      flash[:success] = 'コメントしました'
      redirect_to @comment.topic
    else
      @topic = Topic.find(params[:topic_id])
      @comments = @topic.comments
      render template: 'topics/show'
    end
  end
  
  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    flash[:success] = 'コメントを削除しました'
    redirect_to @comment.topic
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

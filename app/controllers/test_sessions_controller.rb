class TestSessionsController < ApplicationController

  def create
    user = User.find_by(email: 'e5khtamcx@test.com')
    session[:user_id] = user.id
    flash[:success] = "ご多用の中ご覧いただきありがとうございます。何卒、よろしくお願いします！"
    redirect_to user
  end
end
class ApplicationController < ActionController::Base
  include SessionsHelper
  before_action :set_search
  
  private
    def set_search
      @q = Topic.ransack(params[:q])
      @topics = @q.result(distinct: true).order(created_at: :desc) 
      q = params[:q]
      unless q == nil #検索ボタンを押したときに実行
        @user_choices = {} #空の連想配列をつくる
        if q["years_id_eq"].present? && q["labels_id_eq"].present?
          @user_choices["学年"] = Year.find(q["years_id_eq"]).year_number
          @user_choices["教科"] = Label.find(q["labels_id_eq"]).name
        elsif (q["years_id_eq"]).present?
          @user_choices["学年"] = Year.find(q["years_id_eq"]).year_number
        elsif (q["labels_id_eq"]).present?
          @user_choices["教科"] = Label.find(q["labels_id_eq"]).name
        else
        end
      end
    end
end
         
          

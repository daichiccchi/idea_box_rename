class ApplicationController < ActionController::Base
  include SessionsHelper
  before_action :set_search
  
  private
    def set_search
      
      @q = Topic.ransack(params[:q])
      @topics = @q.result(distinct: true)
    end
end

require 'test_helper'

class TopicsControllerTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = users(:michael)
    @topic = topics(:one)
  end
  
  test "should get new" do
    get topics_new_url
    assert_response :success
  end
  
  test "should redirect login_url when not logged in" do
    post topics_path(@topic), params: {topic: {image: @topic.image,
                                                  description: @topic.description }}
    assert_not flash.empty?
    assert_redirected_to login_url
  end
  
  test "should redirect topic create when success" do
    log_in_as(@user)
    post topics_path(@topic), params: {topic: {image: @topic.image,
                                                  description: @topic.description }}
    assert_not flash.empty?
    assert_redirected_to topics_url
  end
  
end

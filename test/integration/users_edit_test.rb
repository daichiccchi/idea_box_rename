require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  def setup
    @user = users(:michael)
  end
  
  test "unsuccessful edit" do
    log_in_as(@user)
    get edit_user_path(@user)
    assert_template 'users/edit'
    patch user_path(@user), params: { user: { name:  "",
                                              email: "foo@invalid",
                                              user_area: nil,
                                              user_job: nil,
                                              school_year: nil,
                                              password:              "foo",
                                              password_confirmation: "bar" } }
    assert_template 'users/edit'
    assert_select "div.alert", "The form contains 8 errors."
  end
  
  test "successful edit with friendly forwrding" do
      get edit_user_path(@user)
      log_in_as(@user)
      assert_redirected_to edit_user_url(@user)
      assert_nil (session[:forwarding_url])
      name = "Foo Bar"
      email = "foo@bar.com"
      patch user_path(@user), params: { user: {name: name,
                                              email: email,
                                              user_area: 5,
                                              user_job: 4,
                                              school_year: 2,
                                              password:              "",
                                              password_confirmation: "" } }
      assert_not flash.empty?
      assert_redirected_to @user
      @user.reload
      assert_equal name, @user.name
      assert_equal email, @user.email
  end  
end
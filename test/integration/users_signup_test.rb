require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  def setup
    ActionMailer::Base.deliveries.clear
  end
  
  test "invalid signup information" do  # 新規登録が失敗（フォーム送信が）した時用のテスト
    get signup_path                      # ユーザー登録ページにアクセス
    assert_no_difference 'User.count' do  # User.countでユーザー数が変わっていなければ（ユーザー生成失敗）true,変わっていればfalse
      post users_path, params: { user: { name:  "",           # signup_pathからusers_pathに対してpostリクエスト送信(/usersへ)、paramsでuserハッシュとその下のハッシュで値を受け取れるか確認
                                         email: "user@invalid",
                                         user_area: 1,
                                         user_job:  1,
                                         school_year: 1,
                                         password:              "foo",
                                         password_confirmation: "bar" } }
    end
    assert_template 'users/new'   
  end
  
  test "valid signup information with account activation" do
    get signup_path
    assert_difference "User.count", 1 do
      post users_path, params: { user: { name:  "Example User",
                                         email: "user@example.com",
                                         user_area: 1,
                                         user_job:  1,
                                         school_year: 1,
                                         password:              "password",
                                         password_confirmation: "password" } }
    end
    assert_equal 1,ActionMailer::Base.deliveries.size
    user = assigns(:user)
    assert_not user.activated?
    # 有効化していない状態でログインしてみる
    log_in_as(user)
    assert_not is_logged_in?
    # 有効化トークンが不正な場合
    get edit_account_activation_path("invalid token", email: user.email)
    assert_not is_logged_in?
    # トークンは正しいがメールアドレスが無効な場合
    get edit_account_activation_path(user.activation_token, email: 'wrong')
    assert_not is_logged_in?
    # 有効化トークンが正しい場合
    get edit_account_activation_path(user.activation_token, email: user.email)
    assert user.reload.activated?
    follow_redirect!
    assert_template 'users/show'
    assert is_logged_in?
  end
end
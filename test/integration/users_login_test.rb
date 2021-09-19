require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = users(:michael)
  end
  
  test "login with valid information followed by logout" do
    get login_path  #ログイン用のパスを開く
    post login_path, params: { session: {email: @user.email,
                                         password: 'password' }} #セッション用パスに有効な情報をパスする
    assert is_logged_in?
    assert_redirected_to @user #リダイレクト先が正しいかどうかの確認
    follow_redirect!           #リダイレクト先のページに移動する
    assert_template 'users/show'
    assert_select "a[href=?]", login_path, count: 0 #ログイン用リンクが表示されていないことを確認
    assert_select "a[href=?]", logout_path  #ログアウト用リンクが表示されていることを確認する
    assert_select "a[href=?]", user_path(@user) #プロフィール用リンクが表示されていることを確認する
    
    delete logout_path
    assert_not is_logged_in?
    assert_redirected_to root_url
    #v2番目のウインドウでログアウトをクリックするユーザーをシミュレーションする。
    delete logout_path
    follow_redirect!
    assert_select "a[href=?]", login_path
    assert_select "a[href=?]", logout_path,      count: 0
    assert_select "a[href=?]", user_path(@user), count: 0
  end
  # test "the truth" do
  #   assert true
  # en
  test "login with valid email/invalid password" do #ログイン失敗時のメッセージのテスト
    get login_path  #ログイン用のパスを開く
    assert_template 'sessions/new'#フォームが正しく表示されたか
    post login_path, params: { session:{ email: @user.email, password: "invalid"}}  #空のアドレスとパスワードを送信（セッション用パスにPOST）
    assert_not is_logged_in?
    assert_template "sessions/new" #セッションのページを再表示
    assert_not flash.empty? #フラッシュメッセージが追加されているか
    get root_path # 別のページにいったん移動する
    assert flash.empty? # フラッシュメッセージが消えているか
  end
  
  test "login with remembering" do
    log_in_as(@user, remember_me: '1')
    assert_equal cookies['remember_token'], assigns(:user).remember_token
  end
  
  test "login without remembering" do
    #cookieを保存してログイン
    log_in_as(@user, remember_me: '1')
    delete logout_path
    #cookieを削除してログイン
    log_in_as(@user, remember_me: '0')
    assert_empty cookies[:remember_token]
  end
end
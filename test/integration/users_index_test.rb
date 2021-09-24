require 'test_helper'

class UsersIndexText < ActionDispatch::IntegrationTest
  
  def setup
    @admin     = users(:michael)
    @non_admin = users(:archer)
  end
  
  test "should as admin including pagination and delete links" do
    log_in_as (@admin)
    get users_path
    assert_template 'users/index'
    assert_select "div.pagination", count:2
    first_page_of_users = User.paginate(page: 1)
    first_page_of_users.each do |user|
      assert_select 'a[href=?]', user_path(user), text: user.name
      unless user == @admin #ユーザーが管理者であればスキップ
        assert_select 'a[href=?]', user_path(user), text: 'delete'
      end
    end
    assert_difference "User.count", -1 do #DELETEリクエスト後、ユーザー数が1減ったかどうかを確認
      delete user_path(@non_admin)
    end
  end
  
  test "index as non-admin" do
    log_in_as(@non_admin)
    get users_path
    assert_select 'a', text: 'delete', count: 0 # 管理者ユーザーでなければdeleteのリンクは表示されないかどうかを確認
  end
end
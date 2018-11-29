require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get users_path
    assert_response :success
    assert_select "title", "users | Ruby on Rails Tutorial Sample App"
  end
end

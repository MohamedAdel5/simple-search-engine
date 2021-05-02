require "test_helper"

class AuthControllerTest < ActionDispatch::IntegrationTest
  test "should get signup" do
    get auth_signup_url
    assert_response :success
  end

  test "should get login" do
    get auth_login_url
    assert_response :success
  end
end

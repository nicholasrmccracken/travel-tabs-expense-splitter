require "test_helper"

class UserControllerTest < ActionDispatch::IntegrationTest
  test "should get verify_email" do
    get user_verify_email_url
    assert_response :success
  end
end

require "test_helper"

class User::ReportsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get user_reports_index_url
    assert_response :success
  end
end

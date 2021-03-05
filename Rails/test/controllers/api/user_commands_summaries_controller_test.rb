require "test_helper"

class Api::UserCommandsSummariesControllerTest < ActionDispatch::IntegrationTest
  test "can get all commands sommary" do
    post "/users/sign_in", params: {user: {email: "admin@jfj.com", password: "123456"}}
    get "/api/commands_sommaries/"
    assert_equal(UserCommandsSommary.all.count, response.parsed_body['user_commands_sommary'].count)
    assert_response :success
  end
end

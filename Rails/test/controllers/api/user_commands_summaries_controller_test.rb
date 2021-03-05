require "test_helper"

class Api::UserCommandsSummariesControllerTest < ActionDispatch::IntegrationTest
<<<<<<< HEAD
  # test "the truth" do
  #   assert true
  # end
  test "test can get user commmand summary report for all users " do
    post "/users/sign_in", params: {user: {email: "admin@jfj.com", password: "123456"}}
    get "/api/user_commands_summaries/"
    success = response.parsed_body["success"]
    assert_equal(true,success)
  end
  
  test "test can't get user commmand summary when not admin  " do
    post "/users/sign_in", params: {user: {email: "jere.bern@hotmail.com", password: "123456"}}
    get "/api/user_commands_summaries/"
    success = response.parsed_body["success"]
    error = response.parsed_body["error"]
    assert_equal("not admin",error)
    assert_equal(false,success)
  end

  test "test can't get user commmand summary when not signin" do
    get "/api/user_commands_summaries/"
    success = response.parsed_body["success"]
    error = response.parsed_body["error"]
    assert_equal("not admin",error)
    assert_equal(false,success)
=======
  test "can get all commands sommary" do
    post "/users/sign_in", params: {user: {email: "admin@jfj.com", password: "123456"}}
    get "/api/commands_sommaries/"
    assert_equal(UserCommandsSommary.all.count, response.parsed_body['user_commands_sommary'].count)
    assert_response :success
>>>>>>> 6e73a31370ad8dedaadb6cdbdf63d89754d93075
  end
end

require "test_helper"

class Api::UserCommandsSummariesControllerTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  test "test can get user commmand summary report for all users " do
    User.find(1).picture.attach(io: File.open(Rails.root + "app/assets/images/giraffe.png"), filename: 'giraffe.png')
    post "/users/sign_in", params: {user: {email: "admin@jfj.com", password: "123456"}}
    get "/api/user_commands_summaries/"
    success = response.parsed_body["success"]
    assert_equal(true,success)
  end
  
  test "test can't get user commmand summary when not admin  " do
    User.find(2).picture.attach(io: File.open(Rails.root + "app/assets/images/default.jpg"), filename: 'default.jpg')
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
  end
end

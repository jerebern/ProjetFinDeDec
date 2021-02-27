require 'test_helper'

class Api::UsersControllerTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  test "Can Connect" do 
    post "/users/sign_in", params: {user: {email: "admin@jfj.com", password: "123456"}}
    assert_response :success
  end
  
end

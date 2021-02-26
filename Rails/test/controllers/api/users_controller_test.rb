require 'test_helper'

class Api::UsersControllerTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  test "Can get User" do 
    post "/users/sign_in", params: {user: {email: "admin@jfj.com", password: "123456"}}
    get "/api/users/1"
    assert_response :success
  end
  test "Can't get no existing user" do 
    post "/users/sign_in", params: {user: {email: "admin@jfj.com", password: "123456"}}
    assert_raises(ActiveRecord::RecordNotFound) do
      get "/api/users/666"
    end
  end
  
end
